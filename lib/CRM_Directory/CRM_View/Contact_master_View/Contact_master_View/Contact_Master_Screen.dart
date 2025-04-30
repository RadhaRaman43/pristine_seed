import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../reources/routes/routes_name.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';

class ContactMasterScreen extends StatelessWidget{
  final contact_vm_controller = Get.put(ContactMasterVM());
  final account_vm_controller = Get.put(Accountmastervm());
  Size size = Get.size;
  ScrollController _scrollController = ScrollController();
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
                'Contact Master',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              IconButton(onPressed: () {
                contact_vm_controller.resetAllContactCreativeField('Icon');
                contact_vm_controller.insideOut = true;
                //contact_vm_controller.IsHeDecisionMakerController.value.text = "No";
                contact_vm_controller.getAccountMaster("");
                contact_vm_controller.getDecisionRoleMaster();
                Get.toNamed(RoutesName.addNewContactMaster_screen);
              }, icon: Icon(Icons.add)),

              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  child: Obx(() {
                    //child:
                    return IconButton(onPressed: () {
                      showFilterBottomSheet(context);
                    },
                        icon: Icon(Icons.filter_alt_sharp,
                            color: contact_vm_controller.filterIconColor.value ? AllColors.redColor : AllColors.whiteColor));
                  }
                  ),
                ),
              )
            ],
          )

      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh:contact_vm_controller.refreshList,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Obx((){
                return Visibility(
                  visible:contact_vm_controller.loading.value ,
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

  void showFilterBottomSheet(BuildContext context) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: contact_vm_controller.contact_name_controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                            labelText: 'Contact Name',
                            hintText: 'Contact Name',
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
                          controller: contact_vm_controller.account_name_controller,
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
                          cursorColor: AllColors.primaryDark1,
                          onChanged: (value) {
                            // Handle the text field value changes if needed
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: contact_vm_controller.depart_name_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                            labelText: 'Department Name',
                            hintText: 'Department Name',
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
                          height: 5,
                        ),

                        TextField(
                          controller: contact_vm_controller.emailId_controller,
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
                          height: 5,
                        ),

                        TextField(
                          controller: contact_vm_controller.phone_no_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              labelText: 'Mobile No',
                              hintText: 'Mobile No',
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
                          height: 5,
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
                                  contact_vm_controller.pageNumber=0;
                                  Get.back();
                                  contact_vm_controller.getContactMasterList(
                                    contact_vm_controller.pageNumber,
                                    contact_vm_controller.account_name_controller.text,
                                    contact_vm_controller.contact_name_controller.text,
                                    contact_vm_controller.depart_name_controller.text,
                                  );
                                  contact_vm_controller.filterIconColor.value=true;
                                  print('icon color ${contact_vm_controller.filterIconColor}');
                                  if(contact_vm_controller.account_name_controller.text.isEmpty &&
                                      contact_vm_controller.contact_name_controller.text.isEmpty &&contact_vm_controller.depart_name_controller.text.isEmpty){
                                    contact_vm_controller.filterIconColor.value=false;
                                  }

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
                                  contact_vm_controller.pageNumber=0;
                                  contact_vm_controller.filterIconColor.value=false;
                                  contact_vm_controller.account_name_controller.clear();
                                  contact_vm_controller.contact_name_controller.clear();
                                  contact_vm_controller.depart_name_controller.clear();
                                  contact_vm_controller.emailId_controller.clear();
                                  contact_vm_controller.phone_no_controller.clear();
                                  contact_vm_controller.getContactMasterList(contact_vm_controller.pageNumber, '', '', '');


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
  Widget BindCustomerListView(context) {
    if (contact_vm_controller.contact_master_list.isNotEmpty &&
        contact_vm_controller.contact_master_list!=null &&
        contact_vm_controller.contact_master_list.length > 0   ) {
      ScrollController scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (contact_vm_controller.total_rows /
              contact_vm_controller.rowsPerPage).toInt();
          if ((contact_vm_controller.total_rows % contact_vm_controller.rowsPerPage) > 0)
            total_page += 1;

          print("last index ${contact_vm_controller.pageNumber} ${contact_vm_controller.total_rows} ${contact_vm_controller.rowsPerPage} ${total_page}");

          if (contact_vm_controller.pageNumber + 1 < total_page) {
            contact_vm_controller.getContactMasterList(contact_vm_controller.pageNumber+1, '', '', '');
            this.contact_vm_controller.pageNumber += 1;

          }
        }
      });

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: contact_vm_controller.contact_master_list.value.length,
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
      child: ListTile(
        onTap: () {
          //accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
        },
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Contact Code : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .4,
                  child: Tooltip(
                    message: contact_vm_controller
                        .contact_master_list[position]
                        .contactCode?? "",
                    child: Text(
                      contact_vm_controller
                          .contact_master_list[position]
                          .contactCode?? "",
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
                  "Contact Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .3,
                  child: Tooltip(
                    message: contact_vm_controller
                        .contact_master_list[position]
                        .contactName?? "",
                    child: Text(
                      contact_vm_controller
                          .contact_master_list[position]
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
                    message: contact_vm_controller
                        .contact_master_list[position]
                        .accountName?? "",
                    child: InkWell(
                      onTap: (){
                        account_vm_controller.view='VIEW';
                        contact_vm_controller.view='VIEW';
                        contact_vm_controller.FromPage.value ='Contact';
                        account_vm_controller.getAccMasterBuyCodeApi(contact_vm_controller.contact_master_list[position].accountCode);
                        print('accout code.....${contact_vm_controller.contact_master_list[position].accountCode}');

                      },
                      child: Text(
                        contact_vm_controller
                            .contact_master_list[position]
                            .accountName?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w300),
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
                    message: contact_vm_controller
                        .contact_master_list[position]
                        .emailId?? "",
                    child: Text(
                      contact_vm_controller
                          .contact_master_list[position]
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Phone No. : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                contact_vm_controller
                    .contact_master_list[position]
                      .phoneNo ?? "",
                  overflow: TextOverflow.ellipsis,
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
                  "Department Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: contact_vm_controller
                        .contact_master_list[position]
                        .departmentName?? "",
                    child: Text(
                      contact_vm_controller
                          .contact_master_list[position]
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Designation Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Tooltip(
                    message: contact_vm_controller
                        .contact_master_list[position]
                        .designationname?? "",
                    child: Text(
                      contact_vm_controller
                          .contact_master_list[position]
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
       // leading: bindAvatar( contact_vm_controller.contact_master_list[position].contactName?[0].toUpperCase()?? ""),
        trailing: InkWell(
          onTap: (){
            contact_vm_controller.getAccMasterBuyCodeApi(contact_vm_controller
                .contact_master_list[position]
                .accountCode?? "");
            contact_vm_controller.insideOut = true;
            contact_vm_controller.upDateContact('OutSide', position);
          },
          child: Icon(Icons.update),
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
   /* else
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
            backgroundImage: AssetImage("assets/images/no_file.png"),
          ),
        ),
      );*/

  }

}