import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/utils/app_utils.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';

class ViewContactsScreen extends StatelessWidget{
  final contact_vm_controller = Get.put(ContactMasterVM());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Get.toNamed(RoutesName.update_AccountMaster_screen);
      return false;
    },child: Scaffold(
      appBar:  AppBar(
        backgroundColor: AllColors.primaryDark1,
        iconTheme: IconThemeData(
          color: AllColors.whiteColor,

        ),
          actions: [
            IconButton(
              onPressed: (){
                FilterDialog(context);

              },
              icon: const Icon(Icons.filter_alt_sharp),
            )
          ],
        title:Row(
          children: [
            Text(
              'View Contacts',
              style: GoogleFonts.poppins(
                color: AllColors.whiteColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
          ],
        )

    ),
      drawer: CustomDrawer(),
      body:RefreshIndicator(
        onRefresh:contact_vm_controller.refreshList,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.indigo[200]!, Colors.white],
            ),),
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
              Visibility(
                visible: contact_vm_controller.FromPage.value == 'Contact' || accountMaster_page_controller.FromPage.value == 'Account' ?true:false,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.all(5),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Add New Contact ",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Center(
                          child: IconButton(onPressed: () {
                            contact_vm_controller.insideOut = false;
                            contact_vm_controller.resetAllContactCreativeField('Card');
                            contact_vm_controller.getAccountMaster(contact_vm_controller.pageNumber);
                            contact_vm_controller.getDepartNameList();
                            Get.toNamed(RoutesName.addNewContactMaster_screen);
                          },
                            icon: Icon(Icons.add, size: 40, color: AllColors.textColor,),

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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

    ),
    );
  }
  Widget BindCustomerListView(context) {
    if (accountMaster_page_controller.view_contract_list.value.isNotEmpty && accountMaster_page_controller.view_contract_list.value.length > 0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (accountMaster_page_controller.total_rows /
              accountMaster_page_controller.rowsPerPage).toInt();
          if ((accountMaster_page_controller.total_rows % accountMaster_page_controller.rowsPerPage) > 0)
            total_page += 1;

          //print("last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (accountMaster_page_controller.pageNumber + 1 != total_page) {
            this.accountMaster_page_controller.pageNumber += 1;
            accountMaster_page_controller.getContactMasterList(accountMaster_page_controller.pageNumber, '', '', '');

          }
        }
      });

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: accountMaster_page_controller.view_contract_list.value.length,
          controller: scrollController,
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
    //var createdOn = StaticMethod.convertDateFormat1(contact_vm_controller.contact_master_list[position].createdOn?? "");
    //var updatedOn = StaticMethod.convertDateFormat1(contact_vm_controller.contact_master_list[position].updatedOn?? "");

    return Card(
      margin: EdgeInsets.all(5),
     /* decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),*/
      child: ListTile(
        onTap: () {
          if(contact_vm_controller.FromPage.value == 'Contact'|| accountMaster_page_controller.FromPage.value == 'Account'){
            contact_vm_controller.insideOut = false;
            contact_vm_controller.upDateContact('Inside',position);
          }else{
            print('');
          }

          //accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
        },
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Cont. Code : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message: accountMaster_page_controller
                        .view_contract_list[position]
                        .contactCode?? "",
                    child: Text(
                      accountMaster_page_controller
                          .view_contract_list[position]
                          .contactCode?? "",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: AllColors.textColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cont. Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message: accountMaster_page_controller
                        .view_contract_list[position]
                        .contactName?? "",
                    child: Text(
                      accountMaster_page_controller
                          .view_contract_list[position]
                          .contactName?? "",
                      overflow: TextOverflow.ellipsis,
                      style:GoogleFonts.poppins(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Acc. Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message: accountMaster_page_controller
                        .view_contract_list[position]
                        .accountName?? "",
                    child: InkWell(
                      onTap: (){

                      },
                      child: Text(
                        accountMaster_page_controller
                            .view_contract_list[position]
                            .accountName?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: AllColors.textColor,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email Id : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message: accountMaster_page_controller
                        .view_contract_list[position]
                        .emailId?? "",
                    child: Text(
                      accountMaster_page_controller
                          .view_contract_list[position]
                          .emailId?? "",
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
            Row

              (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phone No. : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Text(
                    accountMaster_page_controller
                        .view_contract_list[position]
                        .phoneNo ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: AllColors.textColor,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Depart. Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .5,
                  child: Tooltip(
                    message: accountMaster_page_controller
                        .view_contract_list[position]
                        .departmentName?? "",
                    child: Text(
                      accountMaster_page_controller
                          .view_contract_list[position]
                          .departmentName?? "",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Desig. Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message: accountMaster_page_controller
                        .view_contract_list[position]
                        .designationname?? "",
                    child: Text(
                      accountMaster_page_controller
                          .view_contract_list[position]
                          .designationname?? "",
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

          ],
        ),



      ),
    );
  }

  Widget bindAvatar(String? text){
    //if (profile != null && profile != "")
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
            child: Text(text!,style: GoogleFonts.poppins(color: AllColors.primaryDark1,fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w700)),
          ),
        ));


  }

  FilterDialog(context){
    contact_vm_controller.contact_name_controller.clear();
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
              title:  Text(
                'Search Contact',
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
                   Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      //padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextFormField(
                        onChanged: (value) => accountMaster_page_controller.getContactMasterList(
                          contact_vm_controller.pageNumber, '', contact_vm_controller.contact_name_controller.text, contact_vm_controller.accountCode.value.toString()),
                        controller: contact_vm_controller.contact_name_controller,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Icon(Icons.search, color: Colors.black),
                            ),
                            hintText: "Contact Name",
                            labelText: "Contact Name",
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
                  SizedBox(height: 55,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AllColors.lightredColor, // <-- Button color
                              foregroundColor: AllColors.lightredColor,
                              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(20))
                          ),
                          onPressed: (){
                            Navigator.pop(context, false);
                            contact_vm_controller.contact_name_controller.clear();
                            accountMaster_page_controller.getContactMasterList(
                              contact_vm_controller.pageNumber, accountMaster_page_controller.accountName, contact_vm_controller.contact_name_controller.text,contact_vm_controller.accountCode.value.toString());
                          },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('Cancel',
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AllColors.greenblue, // <-- Button color
                              foregroundColor: AllColors.greenblue,
                              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(20))
                          ),
                          onPressed: (){
                            if(contact_vm_controller.contact_name_controller.text.isEmpty){
                              Utils.showErrorToastification('Error', 'Please Enter Contact Name');
                            }else {
                              Navigator.pop(context, true);
                              accountMaster_page_controller.getContactMasterList(
                                contact_vm_controller.pageNumber, accountMaster_page_controller.accountName, contact_vm_controller.contact_name_controller.text,contact_vm_controller.accountCode.value.toString());
                              contact_vm_controller.contact_name_controller.clear();

                            }

                          },
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Text('Confirm',
                            /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                            style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontSize: AllFontSize.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),)
                    ],
                  )

                ],
              )
          );
        });
  }




}
