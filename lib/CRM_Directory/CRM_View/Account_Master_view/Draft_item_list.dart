import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';

class DraftItemList extends StatelessWidget{
  DraftItemList({super.key});
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size=Get.size;

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
                'Draft Accounts',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              /*IconButton(onPressed: () {
                showFilterBottomSheet(context);
              }, icon: Icon(Icons.filter_alt_sharp))*/
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: accountMaster_page_controller.refreshDraftList,
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
                  BindCustomerListView(context)
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
    if (accountMaster_page_controller.Account_Master_Draft_list1.isNotEmpty &&
        accountMaster_page_controller.Account_Master_Draft_list1.length > 0  ) {
      ScrollController scrollController = ScrollController();
      print('DraftList1...${accountMaster_page_controller.Account_Master_Draft_list1.length}');
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
            accountMaster_page_controller.getDraftAccountMaster(accountMaster_page_controller.pageNumber + 1,accountMaster_page_controller.is_Active.toString());
            this.accountMaster_page_controller.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: accountMaster_page_controller.Account_Master_Draft_list1.length,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return BindCustomerRequestListView(context, index);
          });
    } else {
      print('DraftList2...${accountMaster_page_controller.Account_Master_Draft_list1.length}');
      return Center(
        child: Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
      );
    }
  }

  Widget BindCustomerRequestListView(context, int position){
    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          accountMaster_page_controller.view = 'FromDraft';
         // print('Adreesss..${accountMaster_page_controller.Account_Master_Draft_list[position].address}');
          accountMaster_page_controller.fillDraftDetails(accountMaster_page_controller.Account_Master_Draft_list1, position);
          Get.toNamed(RoutesName.add_New_AccountMaster_screen);
         // accountMaster_page_controller.getCompanyProfileSubTypeApi(accountMaster_page_controller.Account_Master_list[position].companyProfileType);
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
                        .Account_Master_Draft_list1[position]
                        .accountName!,
                    child: Text(
                      accountMaster_page_controller
                          .Account_Master_Draft_list1[position]
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
                        .Account_Master_Draft_list1[position]
                        .accountType!,
                    child: Text(
                      accountMaster_page_controller
                          .Account_Master_Draft_list1[position]
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
                      .Account_Master_Draft_list1[position]
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
                        .Account_Master_Draft_list1[position]
                        .companyProfileSubType!,
                    child: Text(
                      accountMaster_page_controller
                          .Account_Master_Draft_list1[position]
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
                        .Account_Master_Draft_list1[position]
                        .permanentAddress!.address!,
                    child: Text(
                      accountMaster_page_controller
                          .Account_Master_Draft_list1[position]
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
                        .Account_Master_Draft_list1[position]
                        .accountCategoryType!,
                    child: Text(
                      accountMaster_page_controller
                          .Account_Master_Draft_list1[position]
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

          ],
        ),
        /*leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            bindAvatar(accountMaster_page_controller.Account_Master_Draft_list1[position].profile),
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
            backgroundImage: AssetImage('assests/images/no_image_placeholder.png'),
          ),
        ),
      );

  }
}