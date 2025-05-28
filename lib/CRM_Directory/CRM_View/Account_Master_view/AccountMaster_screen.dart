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

  static String _displayAccCategoryForOption(CustomList option) =>
      option.value!;

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
              IconButton(onPressed: () {
                accountMaster_page_controller.DraftId = '';
                accountMaster_page_controller.clearController();
                accountMaster_page_controller.getCompanyProfileTypeApi("");
                accountMaster_page_controller.getGeoPostalCodeApi();
                Get.toNamed(RoutesName.add_New_AccountMaster_screen);
              }, icon: Icon(Icons.add)),
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
            accountMaster_page_controller.getAccountMaster(accountMaster_page_controller.pageNumber + 1,accountMaster_page_controller.is_Active.toString());
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
    int? IsActive = accountMaster_page_controller.Account_Master_list[position].isActive;
    String isActive = "";
    if(IsActive == 1){
      isActive = "Yes";
    }else{
      isActive = "No";
    }
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
          onTap: () {
            accountMaster_page_controller.FromPage.value = 'Account';
            accountMaster_page_controller.view = 'Account';
            accountMaster_page_controller.getEmployeeMemberApi();
            accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
            accountMaster_page_controller.getCompanyProfileSubTypeApi(accountMaster_page_controller.Account_Master_list[position].companyProfileType);
            accountMaster_page_controller.getGeoPostalCodeApi();
            //todo for state , city and district....
            accountMaster_page_controller.getShippingStateMasterApi(accountMaster_page_controller.PostCode_Controller.text,'state');
            accountMaster_page_controller.getShippingStateMasterApi(accountMaster_page_controller.PostCode_Controller.text,'city');
            accountMaster_page_controller.getShippingStateMasterApi(accountMaster_page_controller.PostCode_Controller.text,'district');

          },
          subtitle: Column(
            children: [
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
                          .accountName!,
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountName!,
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
                          .accountType!,
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountType!,
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
                        .companyProfileType!,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
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
                          .companyProfileSubType!,
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .companyProfileSubType!,
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
                          .permanentAddress!.address!,
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .permanentAddress!.address!,
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
                          .accountCategoryType!,
                      child: Text(
                        accountMaster_page_controller
                            .Account_Master_list[position]
                            .accountCategoryType!,
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
          ),
        /*leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            bindAvatar(accountMaster_page_controller.Account_Master_list[position].profile),
            VerticalDivider(color: Colors.grey),
          ],
        ),*/
         trailing: InkWell(
           child: Icon(Icons.update),
         ),
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
    accountMaster_page_controller.IsActive_controller.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
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
              SingleChildScrollView(
                child: Container(
                  //height: size.height*.40,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
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
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),


                        bindAccountTypeDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        bindAccCatogeryTypeDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        TextField(
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
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        TextField(
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
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        bindCompProfileTypeDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

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
                        ),

                        TextField(
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
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        bindAnualRevenueDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        bindNoOfEmpDropDown(context),

                        SizedBox(
                          height: 10,
                        ),

                        bindIsActiveDropDown(context),

                        SizedBox(
                          height: 10,
                        ),


                        Row(
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
                                  accountMaster_page_controller.account_name_controller.clear();
                                  accountMaster_page_controller.account_type_controller.clear();
                                  accountMaster_page_controller.comp_prof_type_controller.clear();
                                  accountMaster_page_controller.account_cat_type_controller.clear();
                                  accountMaster_page_controller.stateName_controller.clear();
                                  accountMaster_page_controller.Address_controller.clear();
                                  accountMaster_page_controller.Annual_Revenue_Controller.clear();
                                  accountMaster_page_controller.No_Of_Emp_Controller.clear();
                                  accountMaster_page_controller.IsActive_controller.clear();
                                  accountMaster_page_controller.PhoneNo_Controller.clear();
                                  accountMaster_page_controller.EmailId_Controller.clear();
                                  accountMaster_page_controller.no_of_employees_min = '';
                                  accountMaster_page_controller.no_of_employees_max = '';
                                  accountMaster_page_controller.annual_revenue_min = '';
                                  accountMaster_page_controller.annual_revenue_max = '';

                                  accountMaster_page_controller.getAccountMaster(0,'All');

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


                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget bindAccountTypeDropDown(context){
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
  }

  Widget bindAccCatogeryTypeDropDown(context){
    return Autocomplete<CustomList>(
      displayStringForOption: _displayAccCategoryForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return accountMaster_page_controller.get_Acc_category_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return accountMaster_page_controller.get_Acc_category_list
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
  }


  Widget bindIsActiveDropDown(context) {
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

  Widget bindCompProfileTypeDropDown(context){
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
  }



  
}