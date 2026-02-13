import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/component/circular_loading.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/CompanyTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/Employee_Member_Model.dart';
import '../../CRM_Models/AccountMaster_model/cluster_modal.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/region_with_cluster_filter_modal.dart';
import '../../CRM_Models/TaskMaster_model/company_type_modal.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';

class AccountmasterScreen extends StatelessWidget{
  AccountmasterScreen({super.key});
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size=Get.size;

  static String _displayAccTypeForOption(CustomList option) =>
      option.value!;

  static String _displayAccCategoryForOption(GetMasterTypeModel option) =>
      option.code! + " (" + option.description! + ")";

  static String _displayIsActiveForOption(String option) =>
      option;

  static String _displayAnualRevenueForOption(String option) =>
      option;

  static String _displayNoOfEmpForOption(String option) =>
      option;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Get.toNamed(RoutesName.homeScreen);
      return false;
    }, child: Scaffold(
      appBar:  AppBar(
          backgroundColor: AllColors.primaryDark1,
          iconTheme: IconThemeData(
            color: AllColors.whiteColor,
          ),
          title:Row(
            children: [
              Text(
                'Account Master',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Obx((){
               return Visibility(
                 //visible:accountMaster_page_controller.isAdminWritePermission=="0"  ? true:false ,
                 visible:accountMaster_page_controller.isHeadofficePermission!="1"|| accountMaster_page_controller.UserCode?.toLowerCase() == 'cce'  ?true:false ,
                 child: IconButton(onPressed: () {
                   accountMaster_page_controller.yesNoValue.value="No";
                   accountMaster_page_controller.DraftId = '';
                   accountMaster_page_controller.account_type_controller.text='New Account';
                   accountMaster_page_controller.clearController();
                   accountMaster_page_controller.getCompanyProfileSubTypeApi();
                   accountMaster_page_controller.getCompanyProfileTypeApi("");
                   accountMaster_page_controller.getGeoPostalCodeApi(50,'');
                   Get.toNamed(RoutesName.add_New_AccountMaster_screen,arguments: 'Create');
                 }, icon: Icon(Icons.add)),
               );
              }),

              IconButton(onPressed: () {
                showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
          onRefresh: accountMaster_page_controller.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:accountMaster_page_controller.loading.value ,
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
                    child:
                    Obx(() {
                      return BindCustomerListView(context);
                    }),

                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget BindCustomerListView(context) {
    if (accountMaster_page_controller
        .Account_Master_list.value.isNotEmpty &&
        accountMaster_page_controller
            .Account_Master_list.value.length >
            0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (accountMaster_page_controller.total_rows /
              accountMaster_page_controller.rowsPerPage)
              .toInt();
          if ((accountMaster_page_controller.total_rows %
              accountMaster_page_controller.rowsPerPage) >
              0) total_page += 1;

          print("last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (accountMaster_page_controller.pageNumber + 1 < total_page) {
            accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber + 1,accountMaster_page_controller.IsActive_controller.text);
            this.accountMaster_page_controller.pageNumber += 1;
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
          itemCount: accountMaster_page_controller.Account_Master_list.value.length,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      return Center(
        //child: Image.asset("assests/images/no_record_found.gif",),
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position) {
    print('isadminpermosdsdkf....${accountMaster_page_controller.isAdminWritePermission}');
    int? IsActive = accountMaster_page_controller.Account_Master_list[position].isActive;
    String? createdOn = StaticMethod.onlyDate(accountMaster_page_controller.Account_Master_list[position].createdOn??"");
    var controller=accountMaster_page_controller.Account_Master_list[position];
    String isActive = "";
    if(IsActive == 1){
      isActive = "Yes";
    }else{
      isActive = "No";
    }
    final parts = [
      controller.permanentAddress!.address??"",
      controller.permanentAddress!.address2??"",
      controller.permanentAddress!.city??"",
      controller.permanentAddress!.district??"",
      controller.permanentAddress!.stateName??"",
      controller.permanentAddress!.postCode??"",

    ];
    final shippingparts = [
      controller.shippingAddress??"",
      controller.shippingAddress2??"",
      controller.shippingStateName??"",
      controller.shippingCity??"",
      controller.shippingPostCode??"",
    ];

    // Filter out empty strings and join with commas
    final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");
    final shippingfullAddress = shippingparts.where((part) => part.trim().isNotEmpty).join(", ");

   // accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            accountMaster_page_controller.FromPage.value = 'Account';
            accountMaster_page_controller.view = 'Account';
            accountMaster_page_controller.getEmployeeMemberApi();
            accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
            accountMaster_page_controller.getCompanyProfileSubTypeApi();
            accountMaster_page_controller.getGeoPostalCodeApi(50, '');

          },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Customer Code: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: controller.accountCode??"",
                      child: Text(controller.accountCode??"",
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
            InkWell(
              child: accountMaster_page_controller.isAdminWritePermission == "0" ?Icon(Icons.update) : Icon(Icons.remove_red_eye),
            ),
            SizedBox(width: 5,),
            Obx(() {
              return Visibility(
                visible: accountMaster_page_controller.isAdminWritePermission == "1" &&
                    accountMaster_page_controller.isHeadofficePermission == "0",
                child:  GestureDetector(
                    onTap: (){
                      showConfirmCompleteDialog(context,accountMaster_page_controller.Account_Master_list[position].accountCode??"",position!);
                    },
                    child: Icon(Icons.delete, color: Colors.red)),
              );
            }),

          ],
        ),
       /* InkWell(
          child: accountMaster_page_controller.isAdminWritePermission == "0" ?Icon(Icons.update) : Icon(Icons.remove_red_eye),
        )*/
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoRow(context,"Customer Name", controller.accountName??""),
              buildInfoRow(context,"Account Type", controller.accountType??""),
              buildInfoRow(context,"Account Category Type", controller.accountCategoryType??""),
              buildInfoRow(context,"Email Id", controller.emailId??""),
              buildInfoRow(context,"Phone No.", controller.phoneNo??""),
              buildInfoRow(context,"Company Profile Type", controller.companyProfileType??""),
              buildInfoRow(context,"Company Profile Sub Type", controller.companyProfileSubType??""),
              buildInfoRow(context,"Post Code", controller.postCode??""),
              buildInfoRow(context,"Address", fullAddress),
              buildInfoRow(context,"Shipping Address", shippingfullAddress),
              buildInfoRow(context,"Account Owner", controller.accountCreateFullName??""),
              buildInfoRow(context,"Annual Revenue", "₹ ${controller.annualRevenue.toString()??""}"),
              buildInfoRow(context,"No. Of Employees", controller.noOfEmployees.toString()??""),
              buildInfoRow(context,"Old Crm Account No.", controller.oldCrmAccountNo??""),
              buildInfoRow(context,"Region Name", controller.branchHeadValue??""),
              buildInfoRow(context,"Cluster Name", controller.clustureHeadValue??""),
              buildInfoRow(context,"Created By", controller.accountCreateFullName??""),
              buildInfoRow(context,"Created On", createdOn),
             
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Is Active: $isActive",
                  style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: AllFontSize.twelve,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),


      ),
    );
  }

  Widget buildInfoRow(BuildContext context,String label, String? value,{String? account_code, int? index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label: ",
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Tooltip(
            message: value ?? "",
            child: Text(
              value ?? "",
              overflow: TextOverflow.ellipsis,
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

  showConfirmCompleteDialog(BuildContext context,String account_code, int index){
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
                //print("position account master.....${index}");
                accountMaster_page_controller.AccountMstDelete(account_code,index);
              },
              child: Text("Delete",style: TextStyle(color: AllColors.greenblue),),
            ),
          ],
        );
      },
    );
  }


  Widget bindAvatar(String? profile){
    if (profile != null && profile != "")
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes the container circular
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0,        // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
              backgroundColor: AllColors.grayColor,
              backgroundImage: NetworkImage(profile.toString())),
        ),
      );
    else
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes the container circular
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0,        // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: AllColors.grayColor,
            backgroundImage: AssetImage("assests/images/no_file.png"),
          ),
        ),
      );

  }

  void showFilterBottomSheet(BuildContext context) {
    //accountMaster_page_controller.IsActive_controller.clear();
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
                mainAxisSize: MainAxisSize.max, // Ensure minimal height
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
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: 5,),
                              bindData(context,'Customer Code',accountMaster_page_controller.account_code_controller),
                              SizedBox(height: 10,),
                              bindData(context,'Customer Name',accountMaster_page_controller.account_name_controller),
                              SizedBox(height: 10,),
                              bindAccountTypeDropDown(context),
                              SizedBox(height: 10),
                              bindData(context,'Email Id',accountMaster_page_controller.EmailId_Controller),
                              SizedBox(height: 10,),
                              bindData(context,'Phone No.',accountMaster_page_controller.PhoneNo_Controller),
                              SizedBox(height: 10,),
                              //bindData(context,'Company Profile Type',accountMaster_page_controller.comp_prof_type_controller),
                              bindCompProfileTypeDropDown(context),
                              SizedBox(height: 10,),
                              bindData(context,'State Name',accountMaster_page_controller.stateName_controller),
                              SizedBox(height: 10,),
                              bindData(context,'Pin Code',accountMaster_page_controller.postal_code_controller.value),
                              SizedBox(height: 10,),
                              bindData(context,'District',accountMaster_page_controller.district_controller.value),
                              SizedBox(height: 10,),
                              bindIsActiveDropDown(context),
                              SizedBox(height: 10,),
                              bindClusterNameFilter(context),
                              SizedBox(height: 10,),
                              bindRegionNameFilter(context),
                              SizedBox(height: 10,),
                              bindAccountOwnerFilter(context),
                              SizedBox(height: 10,),
                              bindCreatedOn(context),
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
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildButton(
                          text: 'Clear',
                          borderColor: AllColors.redColor,
                          textColor: AllColors.redColor,
                          onTap: () {
                            accountMaster_page_controller.filterDataChecker.value='';
                            accountMaster_page_controller.clearFilterData();
                            accountMaster_page_controller.clearAcountMasterFilter();
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 3,),
                        Expanded(child: _buildButton(
                          text: 'Apply',
                          borderColor: AllColors.primaryDark,
                          textColor: AllColors.primaryDark1,
                          onTap: () {
                            accountMaster_page_controller.pageNumber = 0;
                            accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber, accountMaster_page_controller.IsActive_controller.text);
                            Get.back();
                          },
                        )),
                        const SizedBox(width: 3,),
                        Expanded(child: _buildButton(
                          text: 'Save Filters',
                          borderColor: AllColors.green,
                          textColor: AllColors.green,
                          onTap: () {

                            accountMaster_page_controller.filterDataChecker.value='';
                            accountMaster_page_controller.SaveFilterData();
                            Get.back();
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
                              accountMaster_page_controller.pageNumber = 0;
                              accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber, accountMaster_page_controller.IsActive_controller.text);
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
                              accountMaster_page_controller.clearAcountMasterFilter();

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

  bindData(BuildContext context, String labelText, TextEditingController controller,) {
    return TextField(
      controller: controller,
      keyboardType:labelText=='Phone No.'? TextInputType.phone:TextInputType.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: labelText,
          hintText: labelText,
          hintStyle: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen),
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
  bindCompProfileTypeDropDown(BuildContext context) {
    return Obx(() {
      if (accountMaster_page_controller.comp_prof_type_controller.value.text.isNotEmpty && accountMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = accountMaster_page_controller.comp_prof_type_controller.value.text.split('|');

        accountMaster_page_controller.selected_company_type_list.value =
            List.generate(nameList.length, (index) {
              return CompanyTypeModal(
                description: nameList[index].trim(),
              );
            });
      }
      return DropdownSearch<CompanyTypeModal>.multiSelection(
        items: accountMaster_page_controller.company_profile_type_list,
        itemAsString: (CompanyTypeModal u) => u.description ?? "",
        selectedItems: accountMaster_page_controller.selected_company_type_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,
            labelText: accountMaster_page_controller.selected_company_type_list.isNotEmpty ? "Company Profile Type" : null,
            hintText: "Company Profile Type",
            labelStyle:GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w500),
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
              style: TextStyle(color: AllColors.primaryDark1,
                  fontSize: AllFontSize.sisxteen,
                  fontWeight: FontWeight.w400), // Only black text
            ),
          );
        },
        onChanged: (List<CompanyTypeModal> selectedList) {
          accountMaster_page_controller.selected_company_type_list.value = selectedList;
          accountMaster_page_controller.comp_prof_type_controller.value.text =
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

  Widget bindAccountTypeDropDown(context) {
    return Container(
      //margin: const EdgeInsets.only(right: 15.0),
      width: double.infinity,
      child: DropdownMenu<CustomList>(
        width: size.width-18,
        controller:  accountMaster_page_controller.account_type_controller,
        label: Text(
          "Account Type",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w500),
        ),
       // initialSelection:accountMaster_page_controller.get_Acc_type_list.length>0?accountMaster_page_controller.get_Acc_type_list[1]:null,
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (CustomList? selection) {
          print(selection);
          accountMaster_page_controller.account_type_controller.text =
              _displayAccTypeForOption(selection!).toString();


        },

        dropdownMenuEntries: accountMaster_page_controller.get_Acc_type_list.map<DropdownMenuEntry<CustomList>>((CustomList e) {
          return DropdownMenuEntry<CustomList>(value: e, label: e.value!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }
  bindAccountOwnerFilter(BuildContext context) {
    return Obx((){
      if (accountMaster_page_controller.AccountOwner_controller.value.text.isNotEmpty && accountMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = accountMaster_page_controller.AccountOwner_controller.value.text.split(',');

        accountMaster_page_controller.SelectedEmployee_Member_list.value =
            List.generate(nameList.length, (index) {
              return EmployeeMemberModel(
                fullName: nameList[index].trim(),
              );
            });
      }
      return  DropdownSearch<EmployeeMemberModel>.multiSelection(
        items: accountMaster_page_controller.employee_Member_list,
        itemAsString: (EmployeeMemberModel u) => u.fullName??"",
        selectedItems: accountMaster_page_controller.SelectedEmployee_Member_list,
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: Colors.black),
          dropdownSearchDecoration: InputDecoration(
            filled: false,

            labelText: accountMaster_page_controller.SelectedEmployee_Member_list.isNotEmpty?"Account Owner":null,
            hintText: "Account Owner Name",
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
              "Account Owner Name",
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
              style: TextStyle(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.sisxteen,
            ), // Only black text
            ),
          );
        },
        onChanged: (List<EmployeeMemberModel> selectedList) {
          accountMaster_page_controller.SelectedEmployee_Member_list.value =
              selectedList;
          accountMaster_page_controller.AccountOwner_controller.value.text =
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
                title: Text(item.fullName??"",
                ),
              ),
        ),
      );
    });

  }

  Widget bindAccCatogeryTypeDropDown(context){
    return Autocomplete<GetMasterTypeModel>(
      displayStringForOption: _displayAccCategoryForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Acc_category_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.get_Acc_category_list
            .where((GetMasterTypeModel option) {
          return option.code
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (GetMasterTypeModel selection) {
        print(selection.code);
        // Update the TextField with the selected
        accountMaster_page_controller.account_cat_type_controller.text =
            _displayAccCategoryForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = accountMaster_page_controller.account_cat_type_controller
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
            hintText: 'Customer Category Type',
            labelText: 'Customer Category Type',
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
          AutocompleteOnSelected<GetMasterTypeModel> onSelected,
          Iterable<GetMasterTypeModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final GetMasterTypeModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:  option.code!,
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                ),
                              ),
                              TextSpan(
                                text: " (${option.description!})",
                                style: GoogleFonts.poppins(
                                    color: AllColors.redColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                ),
                              ),
                            ],
                          ),
                          softWrap: true,
                        )
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

  Widget bindIsActiveDropDown(context) {
    return Container(
      //margin: const EdgeInsets.only(right: 15.0),
      width: double.infinity,
      child: DropdownMenu<String>(
        width: size.width-18,
        controller:  accountMaster_page_controller.IsActive_controller,
        textStyle: TextStyle(
          color: AllColors.primaryDark1,
          fontWeight: FontWeight.w400,
          fontSize: AllFontSize.sisxteen,
        ),
        label: Text(
          "Active",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w500),
        ),
         //initialSelection:"All",
       /* enableFilter: true,
        requestFocusOnTap: true,*/
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten
          ),
        ),
        onSelected: (String? selection) {
          print(selection);
          accountMaster_page_controller.IsActive_controller.text =
              _displayIsActiveForOption(selection!).toString();

        },

        dropdownMenuEntries: accountMaster_page_controller.IsActiveTypeAllList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(
              value: e,
              label: e!,style:
          ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),
          ));
        }).toList(),
      ),
    );
  }

  Widget bindAnualRevenueDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayAnualRevenueForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.AnnualRevenueListFilter;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.AnnualRevenueListFilter
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
        accountMaster_page_controller.Annual_Revenue_Controller.text =
            _displayIsActiveForOption(selection).toString();
        print('AnualReve.....${accountMaster_page_controller.Annual_Revenue_Controller.text}');

        String AnualRevenue = accountMaster_page_controller.Annual_Revenue_Controller.text.toString();
        final anualRevenuelist = AnualRevenue.split("-");
        accountMaster_page_controller.annual_revenue_min = anualRevenuelist[0];
        accountMaster_page_controller.annual_revenue_max = anualRevenuelist[1];
        print('amx..${accountMaster_page_controller.annual_revenue_max}');
        print('amin..${accountMaster_page_controller.annual_revenue_min}');

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = accountMaster_page_controller.Annual_Revenue_Controller
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
              hintText: 'Annual Revenue',
              labelText: 'Annual Revenue',
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

  Widget bindNoOfEmpDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayNoOfEmpForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.NoOfEmpListFilter;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.NoOfEmpListFilter
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
        accountMaster_page_controller.No_Of_Emp_Controller.text =
            _displayIsActiveForOption(selection).toString();
        print('IsActive.....${accountMaster_page_controller.No_Of_Emp_Controller.text}');

        String AnualRevenue = accountMaster_page_controller.No_Of_Emp_Controller.text.toString();
        final anualRevenuelist = AnualRevenue.split("-");
        accountMaster_page_controller.no_of_employees_min = anualRevenuelist[0];
        accountMaster_page_controller.no_of_employees_max = anualRevenuelist[1];
        print('emp..${accountMaster_page_controller.no_of_employees_max}');
        print('emp1..${accountMaster_page_controller.no_of_employees_min}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = accountMaster_page_controller.No_Of_Emp_Controller
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
              hintText: 'No. Of Employee',
              labelText: 'No. Of Employee',
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

  Widget bindClusterNameFilter(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final availableItems = accountMaster_page_controller.clusterGetByEmailList;
      if (accountMaster_page_controller.clusterName_controller.value.text.isNotEmpty && accountMaster_page_controller.filterDataChecker.value=='1') {
        List<String> nameList = accountMaster_page_controller.clusterName_controller.value.text.split('|');
        accountMaster_page_controller.SelectedCluster_list.value =[];
        accountMaster_page_controller.SelectedCluster_list.value =
            List.generate(nameList.length, (index) {
              return ClusterModal(geoValue: nameList[index].trim(),);
            });
      }
      else{
        if (availableItems.isNotEmpty && accountMaster_page_controller.SelectedCluster_list.isEmpty) {
          accountMaster_page_controller.SelectedCluster_list.assignAll(availableItems);
          accountMaster_page_controller.clusterName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          accountMaster_page_controller.getRegionsWithClusterFilterGetByEmail();
        }
      }

    });

    return Obx(() {

      final selected = accountMaster_page_controller.SelectedCluster_list;
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
              final tempSelected = <ClusterModal>[];
              tempSelected.addAll(accountMaster_page_controller.SelectedCluster_list);
              List<ClusterModal> allItems = accountMaster_page_controller.clusterGetByEmailList;

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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AllColors.primaryDark1),
                                ),
                              ),

                              IconButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, icon: Icon(Icons.close,
                                color: AllColors.primaryDark1,weight: 700,))


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
                              suffixIcon: searchController.text.isNotEmpty ? IconButton(
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
                            title: Text(allSelected?'UnSelect All':"Select All"),
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
                          child: filtered.isEmpty ? const Center(child: Text('No clusters found')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            itemBuilder: (context, idx) {
                              final item = filtered[idx];
                              final isSel = tempSelected.any((s) => (s.geoValue ?? "") == (item.geoValue ?? ""));
                              return CheckboxListTile(
                                title: Text(item.geoValue ?? ""),
                                value: isSel,
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      if (!isSel) tempSelected.add(item);
                                    } else {
                                      tempSelected.removeWhere((s) => (s.geoValue ?? "") == (item.geoValue ?? ""));
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        // Done button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
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
                                    accountMaster_page_controller.filterDataChecker.value='';
                                    accountMaster_page_controller.SelectedCluster_list.assignAll(tempSelected);
                                    accountMaster_page_controller.clusterName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
                                    accountMaster_page_controller.getRegionsWithClusterFilterGetByEmail();

                                    Navigator.of(context).pop();
                                  },
                                  child:  Text('Done',style: GoogleFonts.poppins(
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
            labelText: "Cluster Name",
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w500,
                fontSize: AllFontSize.sisxteen),
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
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.sisxteen
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w400,
                          fontSize: AllFontSize.sisxteen),
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
      final availableItems = accountMaster_page_controller.regionwithclusterGetByEmailList;
      if (accountMaster_page_controller.RegionName_controller.value.text.isNotEmpty && accountMaster_page_controller.filterDataChecker.value=='1') {
        accountMaster_page_controller.SelectedRegion_list.value=[];
        List<String> nameList = accountMaster_page_controller.RegionName_controller.value.text.split('|');
        accountMaster_page_controller.SelectedRegion_list.value =
            List.generate(nameList.length, (index) {
              return RegionWithClusterFilterModal(
                geoValue: nameList[index].trim(),
              );
            });
      }
      else{
        if (availableItems.isNotEmpty && accountMaster_page_controller.SelectedRegion_list.isEmpty) {
          accountMaster_page_controller.SelectedRegion_list.assignAll(availableItems);
          accountMaster_page_controller.RegionName_controller.value.text = availableItems.map((e) => e.geoValue).join('|');
          print("bind region ${accountMaster_page_controller.RegionName_controller.value.text}");
        }
        else{
          print("region does not bind first time");
        }
      }
    });

    return Obx(() {
      final selected = accountMaster_page_controller.SelectedRegion_list;
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
              tempSelected.addAll(accountMaster_page_controller.SelectedRegion_list);

              final allItems = accountMaster_page_controller.regionwithclusterGetByEmailList;

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
                                      fontSize: 16, fontWeight: FontWeight.w600,
                                      color: AllColors.primaryDark1),
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
                            title: Text(allSelected?'UnSelect All':"Select All"),
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
                          child: filtered.isEmpty ? const Center(child: Text('No regions found')) : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                              horizontal: 50.0, vertical: 20),
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
                                    accountMaster_page_controller.filterDataChecker.value='';
                                    accountMaster_page_controller.SelectedRegion_list.assignAll(tempSelected);
                                    accountMaster_page_controller.RegionName_controller.value.text = tempSelected.map((e) => e.geoValue).join('|');
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
            labelText: "Region Name",
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w400,
                fontSize: AllFontSize.sisxteen),
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
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.sisxteen
                  ),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    selectedText,
                      style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.sisxteen)
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
  
  
  bindCreatedOn(BuildContext context) {
    return TextField(
        cursorColor: AllColors.primaryDark1,
        controller: accountMaster_page_controller.created_on_controller.value,
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
            accountMaster_page_controller.created_on_controller.value.text = outputFormat.format(date);
          else
            accountMaster_page_controller.created_on_controller.value.text = "";
        }

    );
  }
  
}