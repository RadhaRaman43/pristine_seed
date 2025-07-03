import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/AccountMaster_model/CompanyTypeModel.dart';
import '../../CRM_Models/AccountMaster_model/getMasterTypeModel.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';

class AccountmasterScreen extends StatelessWidget{
  AccountmasterScreen({super.key});
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size=Get.size;

  static String _displayAccTypeForOption(CustomList option) =>
      option.value!;

  static String _displayAccCategoryForOption(GetMasterTypeModel option) =>
      option.code! + " (" + option.description! + ")";

  static String _displayCompProfileTypeForOption(CompanyTypeModel option) =>
      option.description!;

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
              Visibility(
                visible: accountMaster_page_controller.isAdminWritePermission=="0"?true:false,
                child: IconButton(onPressed: () {
                  accountMaster_page_controller.DraftId = '';
                  accountMaster_page_controller.account_type_controller.text='New Account';
                  accountMaster_page_controller.clearController();
                  accountMaster_page_controller.getCompanyProfileSubTypeApi();
                  accountMaster_page_controller.getCompanyProfileTypeApi("");
                  accountMaster_page_controller.getGeoPostalCodeApi();
                  Get.toNamed(RoutesName.add_New_AccountMaster_screen);
                }, icon: Icon(Icons.add)),
              ),

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

          print(
              "last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

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
    var controller=accountMaster_page_controller.Account_Master_list[position];
    String isActive = "";
    if(IsActive == 1){
      isActive = "Yes";
    }else{
      isActive = "No";
    }
    final parts = [
      controller.permanentAddress!.address!,
      controller.permanentAddress!.address2!,
      controller.permanentAddress!.city!,
      controller.permanentAddress!.district!,
      controller.permanentAddress!.stateName!,
      controller.permanentAddress!.postCode!,

    ];

    // Filter out empty strings and join with commas
    final fullAddress = parts.where((part) => part.trim().isNotEmpty).join(", ");

   // accountMaster_page_controller.FullAddress_Controller.value.text = fullAddress;
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            accountMaster_page_controller.FromPage.value = 'Account';
            accountMaster_page_controller.view = 'Account';
            accountMaster_page_controller.getEmployeeMemberApi();
            accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
            accountMaster_page_controller.getCompanyProfileSubTypeApi(/*accountMaster_page_controller.Account_Master_list[position].companyProfileType*/);
            accountMaster_page_controller.getGeoPostalCodeApi();

          },
          subtitle:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoRow("Account Code", controller.accountCode),
              buildInfoRow("Account Name", controller.accountName),
              buildInfoRow("Account Type", controller.accountType),
              buildInfoRow("Company Type", controller.companyProfileType),
              buildInfoRow("Company Sub Type", controller.companyProfileSubType),
              buildInfoRow("Email Id", controller.emailId),
              buildInfoRow("Phone No.", controller.phoneNo),
              buildInfoRow("Created By", controller.createdBy),
             // buildInfoRow("Frontliner Value", controller.frontlinerValue),
              buildInfoRow("Region Name", controller.branchHeadValue),
             // buildInfoRow("Zone Head Value", controller.zoneHeadValue),
              buildInfoRow("Cluster Name", controller.clustureHeadValue),
              //buildInfoRow("Address", controller.permanentAddress!.address! + ","+ controller.permanentAddress!.address2! + ", " + controller.permanentAddress!.city! + ","+ "\n" + controller.permanentAddress!.district! + ","+ controller.permanentAddress!.stateName! + ","+  controller.permanentAddress!.postCode!),
              buildInfoRow("Address", fullAddress),
             // buildInfoRow("Shipping Address", fullAddress),
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

          /* Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .accountCode??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountCode??"",
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
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Name : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .accountName??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountName??"",
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
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Type : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .accountType??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountType??"",
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
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Company Type : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    accountMaster_page_controller
                        .Account_Master_list[position]
                        .companyProfileType??"",
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Company Sub Type : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .3,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .companyProfileSubType??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .companyProfileSubType??"",
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
                    "Email Id : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .emailId??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .emailId??"",
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
                    "Phone No.: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .phoneNo??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .phoneNo??"",
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
                    "Created By: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .createdBy??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .createdBy??"",
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
                    "Frontliner Value: ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .frontlinerValue??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .frontlinerValue??"",
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
                    "Branch Head Value ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .branchHeadValue??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .branchHeadValue??"",
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
                    "Zone Head Value ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .zoneHeadValue??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .zoneHeadValue??"",
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
                    "Cluster Head Value ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .clustureHeadValue??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .clustureHeadValue??"",
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
                    "Address : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .4,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .permanentAddress!.address??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .permanentAddress!.address??"",
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
              *//*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Account Category Type : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: size.width * .2,
                    child: Tooltip(
                      message: accountMaster_page_controller
                          .Account_Master_list[position]
                          .accountCategoryType??"",
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountCategoryType??"",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),

                ],
              ),*//*

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Is Active : ${isActive}",
                    style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),*/
        /*leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            bindAvatar(accountMaster_page_controller.Account_Master_list[position].profile),
            VerticalDivider(color: Colors.grey),
          ],
        ),*/
         trailing: InkWell(
           child: accountMaster_page_controller.isAdminWritePermission == "0" ?Icon(Icons.update) : Icon(Icons.remove_red_eye),
         ),
      ),
    );
  }

  Widget buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Tooltip(
              message: value ?? "",
              child: Text(
                value ?? "",
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
                                height: 5,
                              ),
                              bindAccountCode(),
                              SizedBox(
                                height: 10,
                              ),
                              bindAccountName(),
                    
                              SizedBox(
                                height: 10,
                              ),
                    
                    
                              bindAccountTypeDropDown(context),
                    
                              SizedBox(
                                height: 10,
                              ),
                    
                              /*bindAccCatogeryTypeDropDown(context),
                    
                          SizedBox(
                            height: 10,
                          ),*/
                    
                              bindEmailId(),
                              SizedBox(
                                height: 10,
                              ),
                              bindPhoneNo(),
                              SizedBox(
                                height: 10,
                              ),
                              bindCompProfileTypeDropDown(),
                              SizedBox(
                                height: 10,
                              ),
                              /*
                          TextField(
                            controller: accountMaster_page_controller.Address_controller,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                                labelText: 'Address',
                                hintText: 'Address',
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
                          ),*/
                              bindSateName(),
                              SizedBox(
                                height: 10,
                              ),
                              bindPostalCode(),
                              SizedBox(
                                height: 10,
                              ),
                              bindDistrict(),
                              SizedBox(
                                height: 10,
                              ),
                              /* bindAnualRevenueDropDown(context),
                          SizedBox(
                            height: 10,
                          ),
                          bindNoOfEmpDropDown(context),
                          SizedBox(
                            height: 10,
                          ),*/
                              bindIsActiveDropDown(context),
                              SizedBox(
                                height: 10,
                              ),
                              bindCreatedBy(),
                              SizedBox(
                                height: 10,
                              ),
                              /*bindFrontLinerValue(),
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
                              accountMaster_page_controller.account_code_controller.clear();
                              accountMaster_page_controller.account_name_controller.clear();
                              accountMaster_page_controller.account_type_controller.clear();
                              accountMaster_page_controller.comp_prof_type_controller.clear();
                              accountMaster_page_controller.stateName_controller.clear();
                              accountMaster_page_controller.IsActive_controller.clear();
                              accountMaster_page_controller.PhoneNo_Controller.clear();
                              accountMaster_page_controller.EmailId_Controller.clear();
                              accountMaster_page_controller.postal_code_controller.value.clear();
                              accountMaster_page_controller.district_controller.value.clear();
                              accountMaster_page_controller.created_by_controller.value.clear();
                              accountMaster_page_controller.frontliner_controller.value.clear();
                              accountMaster_page_controller.branch_head__value_controller.value.clear();
                              accountMaster_page_controller.zone_head__value_controller.value.clear();
                              accountMaster_page_controller.cluster_head__value_controller.value.clear();
                              //accountMaster_page_controller.Address_controller.clear();
                              // accountMaster_page_controller.Annual_Revenue_Controller.clear();
                              //accountMaster_page_controller.No_Of_Emp_Controller.clear();
                              //accountMaster_page_controller.no_of_employees_min = '';
                             // accountMaster_page_controller.no_of_employees_max = '';
                             // accountMaster_page_controller.annual_revenue_min = '';
                              //accountMaster_page_controller.annual_revenue_max = '';
                              //accountMaster_page_controller.account_cat_type_controller.clear();
                             accountMaster_page_controller.pageNumber=0;
                              accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber,'All');

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


 /* Widget bindAccountTypeDropDown(context){
    return Autocomplete<CustomList>(
      displayStringForOption: _displayAccTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Acc_type_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.get_Acc_type_list
            .where((CustomList option) {
          return option.value
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CustomList selection) {
        print(selection.value);
        // Update the TextField with the selected
        accountMaster_page_controller.account_type_controller.text =
            _displayAccTypeForOption(selection).toString();

        accountMaster_page_controller. custome_selection.value=selection;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = accountMaster_page_controller.account_type_controller
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
            hintText: 'Account Type',
            labelText: 'Account Type',
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
          AutocompleteOnSelected<CustomList> onSelected,
          Iterable<CustomList> suggestions) {
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
                  final CustomList option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.value.toString(),
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
  }*/

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
            hintText: 'Account Category Type',
            labelText: 'Account Category Type',
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
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }


 /* Widget bindIsActiveDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIsActiveForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.IsActiveTypeAllList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.IsActiveTypeAllList
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
        accountMaster_page_controller.IsActive_controller.text =
            _displayIsActiveForOption(selection).toString();
        print('IsActive.....${accountMaster_page_controller.IsActive_controller.text}');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = accountMaster_page_controller.IsActive_controller
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
            hintText: 'Active',
            labelText: 'Active',
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
  }*/

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

  /*Widget bindCompProfileTypeDropDown(context){
    return Autocomplete<CompanyTypeModel>(
      displayStringForOption: _displayCompProfileTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Comp_Profile_type_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.get_Comp_Profile_type_list
            .where((CompanyTypeModel option) {
          return option.description
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CompanyTypeModel selection) {
        print(selection.description);
        // Update the TextField with the selected
        accountMaster_page_controller.comp_prof_type_controller.text =
            _displayCompProfileTypeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = accountMaster_page_controller.comp_prof_type_controller
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
            hintText: 'Company Profile Type',
            labelText: 'Company Profile Type',
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
          AutocompleteOnSelected<CompanyTypeModel> onSelected,
          Iterable<CompanyTypeModel> suggestions) {
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
                  final CompanyTypeModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.description.toString(),
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
  }*/

  bindCompProfileTypeDropDown() {
    return TextField(
      cursorColor:AllColors.primaryDark1,
      controller: accountMaster_page_controller.comp_prof_type_controller,
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
  bindAccountCode() {
    return TextField(
      cursorColor:AllColors.primaryDark1,
      controller: accountMaster_page_controller.account_code_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Code',
          hintText: 'Account Code',
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

  bindAccountName() {
    return   TextField(
      cursorColor:AllColors.primaryDark1,
      controller: accountMaster_page_controller.account_name_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Account Name',
          hintText: 'Account Name',
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

  bindEmailId() {
    return  TextField(
      controller: accountMaster_page_controller.EmailId_Controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Email Id',
          hintText: 'Email Id',
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

  bindPhoneNo() {
    return     TextField(
      controller: accountMaster_page_controller.PhoneNo_Controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'Phone No.',
          hintText: 'Phone No.',
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

  bindSateName() {
    return   TextField(
      controller: accountMaster_page_controller.stateName_controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: 'State Name',
          hintText: 'State Name',
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

  bindPostalCode() {
    return TextField(
      controller: accountMaster_page_controller.postal_code_controller.value,
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
      controller: accountMaster_page_controller.district_controller.value,
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
    return  TextField(
      controller: accountMaster_page_controller.created_by_controller.value,
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

  bindFrontLinerValue() {
    return  TextField(
      controller: accountMaster_page_controller.frontliner_controller.value,
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
  }

  bindClusterHead() {
    return TextField(
      controller: accountMaster_page_controller.cluster_head__value_controller.value,
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

  bindZoneHead() {
    return   TextField(
      controller: accountMaster_page_controller.zone_head__value_controller.value,
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
  }

  bindBranchHead() {
    return   TextField(
      controller: accountMaster_page_controller.branch_head__value_controller.value,
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



  
}