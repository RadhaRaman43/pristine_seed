import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/Bussiness_Tour_Plan_Vm/BusinessPlanTour_Vm.dart';
import '../../CRM_VIewModels/Bussiness_Tour_Plan_Vm/Business_Tour_Approval_Vm.dart';

class BussinessTourApproveRejected extends StatelessWidget{
  BussinessTourApproveRejected({super.key});


  BusinessTourApprovalVm businessTourPlanController=Get.put(BusinessTourApprovalVm());
  BusinessPlanTourViewModel businessTourPlanViewController=Get.put(BusinessPlanTourViewModel());
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
                  'Business Tour Plan',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 17.0,
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
          onRefresh:businessTourPlanController.refreshApproveRejectList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:businessTourPlanController.loading.value ,
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
                              businessTourPlanController.filterStatusFlag.value == 'Approved'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Approved',
                                style: GoogleFonts.poppins(
                                  color: businessTourPlanController.filterStatusFlag.value == 'Approved'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                businessTourPlanController.filterStatusFlag.value = 'Approved';
                                businessTourPlanController.pageNumber=0;
                                businessTourPlanController.getBusinessTourApproveRejectListData(businessTourPlanController.pageNumber,  businessTourPlanController.filterStatusFlag.value);
                              },
                            );
                          }),
                          SizedBox(width: 8),
                          Obx(() {
                            return ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
                              backgroundColor:
                              businessTourPlanController.filterStatusFlag.value == 'Rejected'
                                  ? AllColors.primaryDark1
                                  : AllColors.grayColor,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                side: BorderSide(color: AllColors.grayColor),
                              ),
                              label: Text(
                                'Rejected',
                                style: GoogleFonts.poppins(
                                  color: businessTourPlanController.filterStatusFlag.value == 'Rejected'
                                      ? AllColors.whiteColor
                                      : AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                businessTourPlanController.filterStatusFlag.value = 'Rejected';
                                businessTourPlanController.pageNumber=0;
                                businessTourPlanController.getBusinessTourApproveRejectListData(businessTourPlanController.pageNumber,  businessTourPlanController.filterStatusFlag.value);
                              },
                            );
                          }),
                          // optional spacing between chips

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
        ),
      ),
    );
  }

  Widget BindCustomerListView(context) {

    if (businessTourPlanController.BusinessTourApproveRejectList.value.isNotEmpty && businessTourPlanController.BusinessTourApproveRejectList.value.length > 0) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (businessTourPlanController.total_rows /
              businessTourPlanController.rowsPerPage)
              .toInt();
          if ((businessTourPlanController.total_rows %
              businessTourPlanController.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${businessTourPlanController.pageNumber} ${businessTourPlanController.total_rows} ${businessTourPlanController.rowsPerPage} ${total_page}");


          if (businessTourPlanController.pageNumber + 1 < total_page) {
            businessTourPlanController.getBusinessTourApproveRejectListData(businessTourPlanController.pageNumber + 1,businessTourPlanController.filterStatusFlag.value);
            businessTourPlanController.pageNumber += 1;
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
          itemCount: businessTourPlanController.BusinessTourApproveRejectList.value.length,
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
    var createdOn=StaticMethod.dateTimeToDate(businessTourPlanController.BusinessTourApproveRejectList[position].createdOn??"");
    var complatedOn=StaticMethod.dateTimeToDate(businessTourPlanController.BusinessTourApproveRejectList[position].completedOn??"");
    String saleCycleStatus = businessTourPlanController.BusinessTourApproveRejectList[position].status?.toLowerCase()??"";
    Color getStatusColor(String status) {
      switch (status) {
        case 'rejected':
          return AllColors.redColor;
        case 'approved':
          return Colors.green;
        default:
          return Colors.black;
      }
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          businessTourPlanViewController.getBusinessTourPlanDetailsApi(businessTourPlanController.BusinessTourApproveRejectList[position].tourId, "ApproveRejectPage");
        },
        subtitle:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabelWithValue(
              label: "Tour ID : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].tourId,
            ),
            _buildLabelWithValue(
              label: "Cluster: ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].cluster,
              //width: size.width * 0.36,
            ),
            _buildLabelWithValue(
              label: "Region : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].region,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Frontliners : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].frontliners,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Touring Region : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].frontliners,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Status : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].status,
              // width: size.width * 0.36,
              color: getStatusColor(saleCycleStatus),
            ),
            _buildLabelWithValue(
              label: "Frontliners : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].frontliners,
              // width: size.width * 0.36,

            ),
            _buildLabelWithValue(
              label: "Reporting Manager : ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].reportingManager,
              // width: size.width * 0.36,

            ),

            _buildLabelWithValue(
              label: "Created By: ",
              value: businessTourPlanController.BusinessTourApproveRejectList[position].accountCreateFullName,
              //: size.width * 0.33,
            ),


            _buildLabelWithValue(
              label: "Created On: ",
              value: createdOn,
              //: size.width * 0.33,
            ),


            _buildLabelWithValue(
              label: "Completed On: ",
              value: complatedOn,
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
    // accountMaster_page_controller.IsActive_controller.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          // initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure minimal height
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

                              TextField(
                                controller: businessTourPlanController.filterTourIdController.value,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                    labelText: 'Tour ID',
                                    hintText: 'Tour ID',
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
                                controller: businessTourPlanController.filterCreatedByController.value,
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
                              businessTourPlanController.pageNumber = 0;
                              businessTourPlanController.getBusinessTourApprovalListData(businessTourPlanController.pageNumber);
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
                              businessTourPlanController.clearAllFieldOfFilter();
                              businessTourPlanController.pageNumber=0;
                              businessTourPlanController.getBusinessTourApprovalListData(businessTourPlanController.pageNumber);

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

}