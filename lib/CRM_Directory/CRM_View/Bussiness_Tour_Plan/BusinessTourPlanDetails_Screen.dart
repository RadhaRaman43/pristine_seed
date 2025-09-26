import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
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
          if(businessTourPlanController.isSendForApproval.value == ""){
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
                      visible:
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
                      visible:
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
                  Obx((){
                    return Visibility(
                        visible:
                        businessTourPlanController.isSendForApproval.value == "SendForApproval"? true : false,
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
                      visible:
                      businessTourPlanController.BusinessTourHourLines.isNotEmpty &&  businessTourPlanController.BusinessTourPlanDetails_list[0].status != "PENDING"? true : false,
                      child: IconButton(
                        icon: Icon(Icons.download_for_offline_sharp ,size: 30,),
                        onPressed: (){
                          businessTourPlanController.businessPlanReportDownload(businessTourPlanController.BusinessTourPlanDetails_list[0].tourId??"");
                        },
                      )
                    );
                  })

                ],
              )),
          drawer: CustomDrawer(),
          body: Column(
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
                          visible: businessTourPlanController.BusinessTourPlanDetails_list[0].status?.toUpperCase() ==  'PENDING',
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
          ),
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
    businessTourPlanController.RejectReason_Controller.clear();
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
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 15,),
                  bindApprovRejectDropDown(context),
                  SizedBox(height: 55,),
                  Obx(() {
                    return Visibility(
                      visible: businessTourPlanController.RejectBool
                          .value,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
                          controller: businessTourPlanController
                              .RejectReason_Controller,
                          decoration: InputDecoration(
                              hintText: "Reject Reason",
                              labelText: "Reject Reason",
                              //suffixIcon: Icon(Icons.email),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten,
                                  horizontal: AllFontSize.ten),

                              /*focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),*/
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),

                        ),
                      ),
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
                                  if (businessTourPlanController
                                      .RejectReason_Controller.text.isEmpty ||
                                      businessTourPlanController
                                          .RejectReason_Controller == null) {
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

  Widget bindApprovRejectDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayApproveRejectForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return businessTourPlanController.approveRejectList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return businessTourPlanController.approveRejectList
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
                  Row(
                    children: [
                      Text(
                        "Tour ID",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        businessTourPlanController
                                .BusinessTourPlanDetails_list[0].tourId ??
                            "",
                        style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                          //decorationStyle: TextDecorationStyle.wavy,
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
                        "Cluster",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        businessTourPlanController
                                .BusinessTourPlanDetails_list[0].cluster ??
                            "",
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
                        "Region",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        businessTourPlanController
                                .BusinessTourPlanDetails_list[0].region ??
                            "",
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
                        "Frontliners",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        businessTourPlanController
                                .BusinessTourPlanDetails_list[0].frontliners ??
                            "",
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
                        "Touring Region",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        businessTourPlanController
                                .BusinessTourPlanDetails_list[0]
                                .touringRegion ??
                            "",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reporting Manager",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Container(
                        width: size.width*0.34,
                        child: Tooltip(
                          message:businessTourPlanController
                              .BusinessTourPlanDetails_list[0]
                              .reportingManager ??
                              "" ,
                          child: Text(
                            businessTourPlanController
                                    .BusinessTourPlanDetails_list[0]
                                    .reportingManager ??
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
                        "Status",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        Status,
                        style: GoogleFonts.poppins(
                          color: getStatusColor(Status),
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
                        "Start Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        StartDate ?? "",
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
                        "End Date",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        EndDate ?? "",
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
                        "Created On",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        dateTimeCreatedOn ?? "",
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
                ],
              ),
            ),
          ),
        ],
      ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Line No. ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  (businessTourPlanController
                      .BusinessTourHourLines[index].lineNo
                      .toString()),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Touring District : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  businessTourPlanController
                          .BusinessTourHourLines[index].touringDistrict ??
                      "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tour Date : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  TourDate.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tour Type : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  businessTourPlanController
                          .BusinessTourHourLines[index].tourType ??
                      "",
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Accompanied With : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: AccompaniedWith,
                    child: Text(
                      AccompaniedWith,
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customer : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  businessTourPlanController
                      .BusinessTourHourLines[index].customer
                      .toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meeting With : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  MeetingWith,
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Objective : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: businessTourPlanController
                        .BusinessTourHourLines[index].objective
                        .toString(),
                    child: Text(
                      businessTourPlanController
                          .BusinessTourHourLines[index].objective
                          .toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Remark : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: businessTourPlanController
                        .BusinessTourHourLines[index].remark,
                    child: Text(
                      businessTourPlanController
                          .BusinessTourHourLines[index].remark
                          .toString(),
                      style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Created On : ",
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  dateCreatedOn.toString(),
                  style: GoogleFonts.poppins(
                    color: AllColors.textColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
