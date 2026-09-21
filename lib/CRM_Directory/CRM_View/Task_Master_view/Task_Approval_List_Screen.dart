import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../component/circular_loading.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../constants/static_methods.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/Call_Status_Master_model.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';

class TaskApprovalListScreen extends StatelessWidget{

  final TaskMaster_page_controller = Get.put(TaskApprovalvm());
  Size size = Get.size;
  static String _displaySaleCycleActiveForOption(String option) => option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(RoutesName.homeScreen);
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
                  'Task Approval List',
                  style: GoogleFonts.poppins(
                    color: AllColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  TaskMaster_page_controller.isInfraLeadFilterController.text = "All";
                  TaskMaster_page_controller.SaleCycleActive_Controller.text = "All";
                  showFilterBottomSheet(context);
                }, icon: Icon(Icons.filter_alt_sharp))
              ],
            )
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: TaskMaster_page_controller.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx(() {
                  return Visibility(
                    visible: TaskMaster_page_controller.loading.value,
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.textColor,
                    ),
                  );
                }),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 2.0, top: 8.0, right: 2.0, bottom: 8.0),
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
    if (TaskMaster_page_controller.Task_Master_list.value.isNotEmpty) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (TaskMaster_page_controller.total_rows /
              TaskMaster_page_controller.rowsPerPage)
              .toInt();
          if ((TaskMaster_page_controller.total_rows %
              TaskMaster_page_controller.rowsPerPage) >
              0) total_page += 1;

          print(
              "last index ${TaskMaster_page_controller
                  .pageNumber} ${TaskMaster_page_controller
                  .total_rows} ${TaskMaster_page_controller
                  .rowsPerPage} ${total_page}");

          if (TaskMaster_page_controller.pageNumber + 1 < total_page) {
            TaskMaster_page_controller.getTaskMasterApprovalList(
                TaskMaster_page_controller.pageNumber + 1,
                TaskMaster_page_controller.is_Active.toString(),
                );
            TaskMaster_page_controller.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          controller: scrollController,
          padding: EdgeInsets.only(bottom: 10),
          separatorBuilder: (context, index) =>
              Divider(
                height: .05,
                color: Colors.transparent,
              ),
          shrinkWrap: true,
          itemCount: TaskMaster_page_controller
              .Task_Master_list.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        child: Image.asset(
          "assests/images/no_data_remove.png", width: 300, height: 180,),
      );
    }
  }
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending for approval':
        return Colors.yellow[700]!;
      default:
        return Colors.black;
    }
  }
  Widget BindCustomerRequestListView(context, int position) {

    int IsReadyForApprove = TaskMaster_page_controller
        .Task_Master_list[position].isReadyForApprove!;
    String pipeLine = TaskMaster_page_controller.Task_Master_list[position]
        .taskDueTime!.isNotEmpty ? "|" : "";
    // Determine the color based on taskStatus

    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            TaskMaster_page_controller.pageNumber=0;
            TaskMaster_page_controller.clusterName_controller.value.text="";
            TaskMaster_page_controller.RegionName_controller.value.text="";
            TaskMaster_page_controller.getTaskMaster(
              TaskMaster_page_controller.pageNumber,
                TaskMaster_page_controller.is_Active.toString(),
                TaskMaster_page_controller.Task_Master_list[position].taskId,);

          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Task Id : ",
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: TaskMaster_page_controller
                            .Task_Master_list[position]
                            .taskId??"",
                        child: Text(
                          TaskMaster_page_controller
                              .Task_Master_list[position]
                              .taskId??"",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              //color: getStatusColor(taskStatus),
                              color: AllColors.textColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx((){
                    return  Visibility(
                      visible: TaskMaster_page_controller.Task_Master_list[position]
                          .isReadyForApprove.toString()=='1' && TaskMaster_page_controller.Task_Master_list[position].createdBy?.toLowerCase()!=TaskMaster_page_controller.email.toLowerCase()
                          && TaskMaster_page_controller.isHeadofficePermission!="1"?true:false,
                      child: IconButton(onPressed: () {
                        TaskMaster_page_controller.showApprovRejectDialog(context, TaskMaster_page_controller.Task_Master_list[0].taskId!);
                      }, icon: const Icon(Icons.update)),
                    );
                  }),
                ],
              ),
              const Icon(Icons.remove_red_eye, color: AllColors.textColor,),

            ],
          ),
          subtitle: Column(
            children: [
              _buildLabelWithValue(label: "Task Status: ", value: TaskMaster_page_controller.Task_Master_list[position].taskStatus??"",),
              _buildLabelWithValue(label: "Customer Name: ", value: TaskMaster_page_controller.Task_Master_list[position].accountName??"",),
              _buildLabelWithValue(label: "Customer Code: ", value: TaskMaster_page_controller.Task_Master_list[position].accountCode??"",),
              _buildLabelWithValue(label: "Contact Name: ", value: TaskMaster_page_controller.Task_Master_list[position].contactName??"",),
              _buildLabelWithValue(label: "Task Owner: ", value: TaskMaster_page_controller.Task_Master_list[position].taskOwner??"",),
              _buildLabelWithValue(label: "Task Due Date: ", value: StaticMethod.convertDateFormat1(TaskMaster_page_controller.Task_Master_list[position].taskDueDate??""),),
              _buildLabelWithValue(label: "Type Of Call: ", value: TaskMaster_page_controller.Task_Master_list[position].typeOfCall??"",),
              _buildLabelWithValue(label: "Mode of Call: ", value: TaskMaster_page_controller.Task_Master_list[position].methodOfCall??"",),
              _buildLabelWithValue(label: "Last Activity Status: ", value: TaskMaster_page_controller.Task_Master_list[position].lastActivityStatus??"",),
              _buildLabelWithValue(label: "Sales Cycle Id: ", value: TaskMaster_page_controller.Task_Master_list[position].salesCycleId??"",),
              _buildLabelWithValue(label: "Product Category: ", value: TaskMaster_page_controller.Task_Master_list[position].productCategory??"",),
              _buildLabelWithValue(label: "Parent Product Category: ", value: TaskMaster_page_controller.Task_Master_list[position].parentProductCategory??"",),
              _buildLabelWithValue(label: "Company Profile Type: ", value: TaskMaster_page_controller.Task_Master_list[position].companyProfileType??"",),
              //_buildLabelWithValue(label: "Account Category Type: ", value: TaskMaster_page_controller.Task_Master_list[position].acc??"",),
              _buildLabelWithValue(label: "Along With Person Name: ", value: TaskMaster_page_controller.Task_Master_list[position].alongWithPersonName??"",),
              _buildLabelWithValue(label: "Pin Code: ", value: TaskMaster_page_controller.Task_Master_list[position].postCode??"",),
              _buildLabelWithValue(label: "District: ", value: TaskMaster_page_controller.Task_Master_list[position].district??"",),
              _buildLabelWithValue(label: "Cluster Name: ", value: TaskMaster_page_controller.Task_Master_list[position].clustureHeadValue??"",),
              _buildLabelWithValue(label: "Region Name: ", value: TaskMaster_page_controller.Task_Master_list[position].branchHeadValue??"",),
              _buildLabelWithValue(label: "Task Remarks: ", value: TaskMaster_page_controller.Task_Master_list[position].taskRemarks??"",),
              _buildLabelWithValue(label: "Purpose Of Visit: ", value: TaskMaster_page_controller.Task_Master_list[position].purposeOfVisit??"",),
              _buildLabelWithValue(label: "Last Activity Updated On: ", value: StaticMethod.dateTimeToDate(TaskMaster_page_controller.Task_Master_list[position].lastActivityUpdatedOn??""),),
              _buildLabelWithValue(label: "Created On: ", value: StaticMethod.dateTimeToDate(TaskMaster_page_controller.Task_Master_list[position].createdOn??"") ,),
              _buildLabelWithValue(label: "Created By: ", value:TaskMaster_page_controller.Task_Master_list[position].createdFullName??"" ,),
              _buildLabelWithValue(label: "Reporting Person: ", value: TaskMaster_page_controller.Task_Master_list[position].approvedFullName??"",),
              _buildLabelWithValue(label: "Approved By: ", value: TaskMaster_page_controller.Task_Master_list[position].approvedFullName??"",),
              _buildLabelWithValue(label: "Approved On: ", value:  StaticMethod.convertDateFormat1(TaskMaster_page_controller.Task_Master_list[position].approvedOn??""),),
              Visibility(
                visible: TaskMaster_page_controller.Task_Master_list[position]
                    .taskStatus == 'Rejected' ? true : false,
                child:  _buildLabelWithValue(label: "Rejected Reason: ", value: TaskMaster_page_controller.Task_Master_list[position].rejectReason??"",),
              ),
              _buildLabelWithValue(label: "Manager Remarks: ", value: TaskMaster_page_controller.Task_Master_list[position].managerRemarks??"",),

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
                color:label=="Task Status: "? getStatusColor(value!):color,
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
    //TaskMaster_page_controller.IsActive_controller.clear();
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
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
              ),
              child: Column(
                //mainAxisSize: MainAxisSize.min, // Ensure minimal height
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_moon_rounded,
                          color: AllColors.primaryDark1,),
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
                              SizedBox(height: 5,),
                              bindData(context,'Task Id',TaskMaster_page_controller.filterTask_Id_controller.value),
                              SizedBox(height: 5,),
                              bindData(context,'Customer Name',TaskMaster_page_controller.account_Name_controller.value),
                              SizedBox(height: 10,),
                              bindData(context,'Customer Code',TaskMaster_page_controller.account_code_controller.value),
                              SizedBox(height: 10,),
                              bindTypeOfCallDropDown(context),
                              SizedBox(height: 10,),
                              bindMethodOfCallDropDown(context),
                              SizedBox(height: 10,),
                              bindCompProfileTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindLastActivityStatus(context),
                              SizedBox(height: 10,),
                              bindSaleCycleActiveDropDown(context),
                              SizedBox(height: 10,),
                              filterWithTaskDueDate(context),
                              SizedBox(height: 10,),
                              bindData(context,'Pin Code',TaskMaster_page_controller.postalCodeController.value),
                              SizedBox(height: 10,),
                              bindData(context,'District',TaskMaster_page_controller.district_controller.value),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindAccountOwnerFilter(context),
                              SizedBox(height: 10,),
                              bindCreatedOn(context),
                              SizedBox(height: 10,),
                              bindProductCategory(context),
                              SizedBox(height: 10,),
                              bindParentProductCategoryFilter(context),
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
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            Get.back();
                            TaskMaster_page_controller.resetAllFieldOfFilter();
                            TaskMaster_page_controller.clearFilterData();
                            TaskMaster_page_controller.pageNumber = 0;
                            TaskMaster_page_controller.getTaskMasterApprovalList(
                              TaskMaster_page_controller.pageNumber, TaskMaster_page_controller.is_Active.toString(),);
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            Get.back();
                            TaskMaster_page_controller.pageNumber = 0;
                            TaskMaster_page_controller.getTaskMasterApprovalList(
                              TaskMaster_page_controller.pageNumber,
                              TaskMaster_page_controller.SaleCycleActive_Controller.text,
                            );
                          },
                        )),
                        const SizedBox(width: 6),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {
                            Get.back();
                            TaskMaster_page_controller.SaveFilterData();
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

  bindData(BuildContext context,String labelText, TextEditingController controller) {
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
  bindTypeOfCallDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.Type_of_call_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.Type_of_call_controller.value.text.split('|');

        TaskMaster_page_controller.Selection_CallStatus_Master_list.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: TaskMaster_page_controller.CallStatus_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: TaskMaster_page_controller.Selection_CallStatus_Master_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.Selection_CallStatus_Master_list.isNotEmpty ? "Type Of Call" : null,
            hintText:  "All" ,
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
              "All",
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
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          TaskMaster_page_controller.Selection_CallStatus_Master_list.value = selectedList;
          TaskMaster_page_controller.Type_of_call_controller.value.text =
              selectedList.where((e) => e.taskStatus?.toLowerCase() != 'all').map((e) => e.taskStatus).join('|');
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
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }
  bindMethodOfCallDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.method_of_call_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.method_of_call_controller.value.text.split('|');

        TaskMaster_page_controller.Selection_MethodOfCall_Master_list.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: TaskMaster_page_controller.MethodOfCall_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: TaskMaster_page_controller.Selection_MethodOfCall_Master_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.Selection_MethodOfCall_Master_list.isNotEmpty ? "Mode Of Call" : null,
            hintText: "All",
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
              "All",
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
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          TaskMaster_page_controller.Selection_MethodOfCall_Master_list.value = selectedList;
          TaskMaster_page_controller.method_of_call_controller.value.text =
              selectedList.where((e) => e.taskStatus?.toLowerCase() != 'all').map((e) => e.taskStatus).join('|');
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
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }
  bindCompProfileTypeDropDown(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.companyProfileTypeController.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.companyProfileTypeController.value.text.split('|');

        TaskMaster_page_controller.selected_company_type_list.value =
            List.generate(nameList.length, (index) {
              return CompanyTypeModal(
                description: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CompanyTypeModal>.multiSelection(
        items: TaskMaster_page_controller.company_profile_type_list,
        itemAsString: (CompanyTypeModal u) => u.description ?? "",
        selectedItems: TaskMaster_page_controller.selected_company_type_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.selected_company_type_list.isNotEmpty ? "Company Profile Type" : null,
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
          TaskMaster_page_controller.selected_company_type_list.value = selectedList;
          TaskMaster_page_controller.companyProfileTypeController.value.text =
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

  bindLastActivityStatus(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.lastActivityStatus_Controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.lastActivityStatus_Controller.value.text.split('|');

        TaskMaster_page_controller.selectedDSARStatusList.value =
            List.generate(nameList.length, (index) {
              return CallStatusMasterModel(
                taskStatus: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CallStatusMasterModel>.multiSelection(
        items: TaskMaster_page_controller.DSARStatus_Master_list,
        itemAsString: (CallStatusMasterModel u) => u.taskStatus ?? "",
        selectedItems: TaskMaster_page_controller.selectedDSARStatusList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText:
            TaskMaster_page_controller.selectedDSARStatusList.isNotEmpty
                ? "Last Activity Status"
                : null,
            hintText: "Last Activity Status",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Last Activity Status",
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
              selectedItems.map((e) => e.taskStatus).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<CallStatusMasterModel> selectedList) {
          TaskMaster_page_controller.selectedDSARStatusList.value = selectedList;
          TaskMaster_page_controller.lastActivityStatus_Controller.value.text =
              selectedList.map((e) => e.taskStatus).join('|');
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
            title: Text(item.taskStatus ?? ""),
          ),
        ),
      );
    });
  }
  Widget bindSaleCycleActiveDropDown(context) {
    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: TaskMaster_page_controller.SaleCycleActive_Controller,
      label: Text(
        "Sales Cycle Active",
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
        TaskMaster_page_controller.SaleCycleActive_Controller.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },

      dropdownMenuEntries: TaskMaster_page_controller.SaleCycleActiveTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }
  filterWithTaskDueDate(BuildContext context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: TaskMaster_page_controller.filterTaskDuedateController.value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        suffixIcon: Icon(Icons.calendar_month),
        hintText: 'Due Date',
        labelText: 'Due Date',
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
          TaskMaster_page_controller.createdOnStartToEnd.value="$startDate@$endDate";
          TaskMaster_page_controller.filterTaskDuedateController.value.text = '$startDate - $endDate';
        } else {
          TaskMaster_page_controller.filterTaskDuedateController.value.text = '';
          TaskMaster_page_controller.createdOnStartToEnd.value="";
        }
      },
    );
  }


  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = TaskMaster_page_controller.clusterGetByEmailList;
      if (TaskMaster_page_controller.clusterName_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.clusterName_controller.value.text.split('|');
        TaskMaster_page_controller.SelectedCluster_list.value =[];
        TaskMaster_page_controller.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && TaskMaster_page_controller.SelectedCluster_list.isEmpty) {
          TaskMaster_page_controller.SelectedCluster_list.assignAll(availableItems);
          TaskMaster_page_controller.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          TaskMaster_page_controller.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {
      final selected = TaskMaster_page_controller.SelectedCluster_list;
      final selectedText = selected.isEmpty
          ? null : selected.map((e) => e.geoValue).join(', ');

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
              tempSelected.addAll(TaskMaster_page_controller.SelectedCluster_list);

              List<ClusterModal> allItems =
                  TaskMaster_page_controller.clusterGetByEmailList;

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
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {

                                    TaskMaster_page_controller.filterDataChecker.value='';
                                    TaskMaster_page_controller.SelectedCluster_list.assignAll(tempSelected);
                                    TaskMaster_page_controller.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('| ');
                                    TaskMaster_page_controller.getRegionsWithClusterFilterGetByEmail();

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
      final availableItems = TaskMaster_page_controller.regionwithclusterGetByEmailList;
      if (TaskMaster_page_controller.RegionName_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        TaskMaster_page_controller.SelectedRegion_list.value=[];
        List<String> nameList = TaskMaster_page_controller.RegionName_controller.value.text.split('|');
        TaskMaster_page_controller.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && TaskMaster_page_controller.SelectedRegion_list.isEmpty) {
          TaskMaster_page_controller.SelectedRegion_list.assignAll(availableItems);
          TaskMaster_page_controller.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join(',');
          print("bind region ${TaskMaster_page_controller.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });
    return Obx(() {
      final selected = TaskMaster_page_controller.SelectedRegion_list;
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
              tempSelected.addAll(TaskMaster_page_controller.SelectedRegion_list);

              final allItems = TaskMaster_page_controller.regionwithclusterGetByEmailList;

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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    TaskMaster_page_controller.filterDataChecker.value='';
                                    TaskMaster_page_controller.SelectedRegion_list.assignAll(tempSelected);
                                    TaskMaster_page_controller.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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


  Widget bindAccountOwnerFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return Obx(() {
      if (TaskMaster_page_controller.AccountOwner_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        //List<String> nameList = sale_fore_cast_vm.AccountOwner_controller.value.text.split(',');
        List<String> nameList = TaskMaster_page_controller.accountNameCode.split(',');
        TaskMaster_page_controller.SelectedEmployee_Member_list.value = List.generate(nameList.length, (index) {
          debugPrint("empid.... ${nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')'))}");
          return EmployeeMemberModel(
            userFullName: TaskMaster_page_controller.isAdminWritePermission=="1" ?
            nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')):"",
            fullName: TaskMaster_page_controller.isAdminWritePermission!="1"?
            nameList[index].trim().substring(0,nameList[index].trim().indexOf('(')):"",
            salesPersonEmpCode:nameList[index].trim().substring(nameList[index].trim().indexOf('(')+1,nameList[index].trim().indexOf(')')),
          );
        });
      }
      final selected = TaskMaster_page_controller.SelectedEmployee_Member_list;
      final selectedText = selected.isEmpty ? null : selected.map((e) =>
      "${TaskMaster_page_controller.isAdminWritePermission=="1"?e.userFullName ?? "":e.fullName ?? ""}(${e.salesPersonEmpCode ?? ""})").join(', ');
      return GestureDetector(
        onTap: ()  {
          openBottomSheet(context);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: selectedText != null ?  "Task Owner": "", // 👈 Label restored here
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
                  "Task Owner",
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

  openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16)),),
        builder: (context){
          TaskMaster_page_controller.tempSelected.value = [];
          TaskMaster_page_controller.tempSelected.addAll(TaskMaster_page_controller.SelectedEmployee_Member_list);
          TaskMaster_page_controller.filtered.value = TaskMaster_page_controller.employee_Member_list;
          return Obx((){
            TaskMaster_page_controller.allSelected.value = TaskMaster_page_controller.filtered.isNotEmpty
                && TaskMaster_page_controller.tempSelected.length == TaskMaster_page_controller.filtered.length;
            return Visibility(
                visible: TaskMaster_page_controller.selectOwner.value,
                child: Padding(
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
                                  'Select Task Owner',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w600,color: Colors.black),
                                ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: const Icon(Icons.close,color: AllColors.primaryDark1,weight: 700,))

                            ],
                          ),
                        ),
                        // Search Field
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: TaskMaster_page_controller.searchController.value,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              isDense: true,
                              suffixIcon: TaskMaster_page_controller.searchController.value.text.isNotEmpty ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  TaskMaster_page_controller.searchController.value.clear();
                                  if(TaskMaster_page_controller.isAdminWritePermission=="1") {
                                    TaskMaster_page_controller.EmployeeMasterGet(TaskMaster_page_controller.searchController.value.text);
                                  }
                                  else{
                                    TaskMaster_page_controller.filtered.value =TaskMaster_page_controller.searchController.value.text.isEmpty ?
                                    TaskMaster_page_controller.employee_Member_list:TaskMaster_page_controller.employee_Member_list.where((c) =>
                                        (c.fullName ?? "").toLowerCase().contains(TaskMaster_page_controller.searchController.value.text)).toList();
                                  }


                                },
                              ) : null,
                            ),
                            onChanged: (v)
                            {
                              if(TaskMaster_page_controller.isAdminWritePermission=="1") {
                                TaskMaster_page_controller.EmployeeMasterGet(TaskMaster_page_controller.searchController.value.text);
                              }
                              else{
                                TaskMaster_page_controller.filtered.value =TaskMaster_page_controller.searchController.value.text.isEmpty ?
                                TaskMaster_page_controller.employee_Member_list:TaskMaster_page_controller.employee_Member_list.where((c) =>
                                    ("${c.fullName ?? ""} ${c.salesPersonEmpCode ?? ""}").toLowerCase().contains(TaskMaster_page_controller.searchController.value.text)).toList();
                              }

                            },
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Select All
                        /* Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CheckboxListTile(
                            title:TaskMaster_page_controller.allSelected.value?const Text('UnSelect All'): const Text('Select All'),
                            value: TaskMaster_page_controller.allSelected.value,
                            onChanged: (val) {
                              if (val == true) {
                                TaskMaster_page_controller.tempSelected.clear();
                                TaskMaster_page_controller.allSelected.value=true;
                                TaskMaster_page_controller.tempSelected.addAll(TaskMaster_page_controller.filtered);
                              } else {
                                TaskMaster_page_controller.allSelected.value=false;
                                TaskMaster_page_controller.tempSelected.clear();
                              }
                              TaskMaster_page_controller.selectOwner.value=false;
                              TaskMaster_page_controller.selectOwner.value=true;
                            },
                          ),
                        ),*/

                        const Divider(height: 1),
                        Obx((){
                          return Visibility(visible:TaskMaster_page_controller.loading.value,
                            child:LinearProgressIndicator(
                              backgroundColor: AllColors.primaryDark1,
                              color: AllColors.textColor,
                            ), );
                        }),


                        // List
                        Expanded(
                          child: TaskMaster_page_controller.filtered.isEmpty ? const Center(child: Text('No Record Found!')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: TaskMaster_page_controller.filtered.length,
                            itemBuilder: (context, idx) {
                              final item = TaskMaster_page_controller.filtered[idx];
                              TaskMaster_page_controller.isSel.value = TaskMaster_page_controller.tempSelected.any((s) =>
                              (TaskMaster_page_controller.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                  (TaskMaster_page_controller.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                              return CheckboxListTile(
                                title: Text("${TaskMaster_page_controller.isAdminWritePermission=="1"?
                                item.userFullName ?? "":item.fullName ?? ""}(${item.salesPersonEmpCode ?? ""})"),
                                value: TaskMaster_page_controller.isSel.value,
                                onChanged: (v) {
                                  if (v == true) {
                                    TaskMaster_page_controller.isSel.value=true;
                                    TaskMaster_page_controller.tempSelected.add(item);
                                  } else {
                                    TaskMaster_page_controller.isSel.value=false;
                                    TaskMaster_page_controller.tempSelected.removeWhere((s) =>
                                    (TaskMaster_page_controller.isAdminWritePermission=="1"?s.userFullName ?? "":s.fullName ?? "") ==
                                        (TaskMaster_page_controller.isAdminWritePermission=="1"?item.userFullName ?? "":item.fullName ?? ""));
                                    //(s.userFullName ?? "") == (item.userFullName ?? ""));
                                  }
                                  TaskMaster_page_controller.selectOwner.value=false;
                                  TaskMaster_page_controller.selectOwner.value=true;
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
                                    TaskMaster_page_controller.SelectedEmployee_Member_list
                                        .assignAll(TaskMaster_page_controller.tempSelected);

                                    TaskMaster_page_controller.accountNameCode= TaskMaster_page_controller.tempSelected.map((nameCode)
                                    =>"${TaskMaster_page_controller.isAdminWritePermission=="1"?nameCode.userFullName??"":nameCode.fullName??""}(${nameCode.salesPersonEmpCode})" ).join(', ') ;

                                    TaskMaster_page_controller.AccountOwner_controller.value.text =
                                        TaskMaster_page_controller.tempSelected.map((e) => e.empId).join(', ');

                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AllColors.primaryDark1,
                                    shadowColor: AllColors.primaryDark1,
                                    foregroundColor: AllColors.primaryDark1,
                                    side: BorderSide(color: AllColors.primaryDark1, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text('Done',style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
        }
    );
  }

  /*bindAccountOwnerFilter(BuildContext context) {
    return Obx((){
      if (TaskMaster_page_controller.AccountOwner_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.AccountOwner_controller.value.text.split(',');

        TaskMaster_page_controller.SelectedEmployee_Member_list.value =
            List.generate(nameList.length, (index) {
              return EmployeeMemberModel(
                fullName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: TaskMaster_page_controller.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: TaskMaster_page_controller.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.SelectedEmployee_Member_list.isNotEmpty?"Account Owner":null,
            hintText: "Task Owner",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              " Task Owner",
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
              selectedItems.map((e) => "${e.fullName ?? ""}(${e.salesPersonEmpCode ?? ""})").join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<EmployeeMemberModel> selectedList) {
          TaskMaster_page_controller.SelectedEmployee_Member_list.value =
              selectedList;
          TaskMaster_page_controller.AccountOwner_controller.value.text =
              selectedList.map((e) => e.empId).join(', ');
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
                title: Text("${item.fullName ?? ""}(${item.salesPersonEmpCode ?? ""})"),
              ),
        ),
      );
    });

  }*/


  bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: TaskMaster_page_controller.filterTaskCreationOnController.value,
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
            TaskMaster_page_controller.filterTaskCreationOnController.value.text = outputFormat.format(date);
          else
            TaskMaster_page_controller.filterTaskCreationOnController.value.text = "";
        }

    );
  }

  bindProductCategory(BuildContext context) {
    return Obx(() {
      if (TaskMaster_page_controller.product_category_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.product_category_controller.value.text.split('|');
        TaskMaster_page_controller.Selected_Item_Category_master_list_without_task.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                categoryName: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: TaskMaster_page_controller.Item_Category_master_list_without_task,
        itemAsString: (ItemCategoryMstModel u) => u.categoryName ?? "",
        selectedItems: TaskMaster_page_controller.Selected_Item_Category_master_list_without_task,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.Selected_Item_Category_master_list_without_task.isNotEmpty ? "Product Category" : null,
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
          TaskMaster_page_controller.Selected_Item_Category_master_list_without_task.value = selectedList;
          TaskMaster_page_controller.product_category_controller.value.text =
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

  bindParentProductCategoryFilter(BuildContext context) {
    return Obx((){
      if (TaskMaster_page_controller.parentProductCategory_controller.value.text.isNotEmpty && TaskMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = TaskMaster_page_controller.parentProductCategory_controller.value.text.split('|');

        TaskMaster_page_controller.selectedParentProductCategoryList.value =
            List.generate(nameList.length, (index) {
              return ItemCategoryMstModel(
                parentCategoryCode: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<ItemCategoryMstModel>.multiSelection(
        items: TaskMaster_page_controller.parentProductCategoryList,
        itemAsString: (ItemCategoryMstModel u) => u.parentCategoryCode??"",
        selectedItems: TaskMaster_page_controller.selectedParentProductCategoryList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: TaskMaster_page_controller.selectedParentProductCategoryList.isNotEmpty?"Parent Product Category":null,
            hintText: "Parent Product Category",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        dropdownBuilder: (context, selectedItems) {
          // Custom builder to just show comma-separated names
          if (selectedItems.isEmpty) {
            return Text(
              "Parent Product Category",
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
              selectedItems.map((e) => e.parentCategoryCode).join(', '),
              style: TextStyle(color: Colors.black), // Only black text
            ),
          );
        },
        onChanged: (List<ItemCategoryMstModel> selectedList) {
          TaskMaster_page_controller.selectedParentProductCategoryList.value = selectedList;
          TaskMaster_page_controller.parentProductCategory_controller.value.text =
              selectedList.map((e) => e.parentCategoryCode).join('|');
        },
        popupProps: PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: 12, right: 12),
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          itemBuilder: (context, item, isSelected) =>
              ListTile(
                title: Text(item.parentCategoryCode??""),
              ),
        ),
      );
    });

  }

  Widget bindProductCategoryTypeDropDown(context) {

    return DropdownMenu<String>(
      width: MediaQuery.of(context).size.width - 15,
      controller: TaskMaster_page_controller.product_category_type_Controller.value,
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
        TaskMaster_page_controller.product_category_type_Controller.value.text =
            _displaySaleCycleActiveForOption(selection!).toString();
      },
      dropdownMenuEntries: TaskMaster_page_controller.productCategoryTypeList
          .map<DropdownMenuEntry<String>>((String e) {
        return DropdownMenuEntry<String>(
            value: e, label: e!, style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              AllColors.primaryDark1),));
      }).toList(),
    );

  }

}