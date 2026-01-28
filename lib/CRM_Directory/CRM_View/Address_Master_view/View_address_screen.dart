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
import '../../CRM_VIewModels/address_master_vm/AddressMasterVM.dart';

class ViewAddressScreen extends StatelessWidget{
  //final contact_vm_controller = Get.put(ContactMasterVM());
  final address_vm_controller = Get.put(Addressmastervm());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(RoutesName.update_AccountMaster_screen);
          return false;
        },
        child: Scaffold(
          appBar:  AppBar(
              backgroundColor: AllColors.primaryDark1,
              iconTheme: IconThemeData(
                color: AllColors.whiteColor,

              ),
              actions: [
                IconButton(
                  onPressed: (){
                    //address_vm_controller.contact_name_controller.clear();
                   // address_vm_controller.Consignee_controller.value.clear();
                   // address_vm_controller.phone_no_controller.clear();
                   // address_vm_controller.emailId_controller.clear();
                    showFilterBottomSheet(context);

                  },
                  icon: const Icon(Icons.filter_alt_sharp),
                )
              ],
              title:Row(
                children: [
                  Text(
                    'View Addresses',
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
            onRefresh:address_vm_controller.refreshList,
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
                      visible:address_vm_controller.loading.value ,
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.textColor,
                      ),
                    );
                  }),
                  Visibility(
                    visible: (accountMaster_page_controller.FromPage.value == 'Contact' || accountMaster_page_controller.FromPage.value == 'Account') && accountMaster_page_controller.isAdminWritePermission=="0"?true:false,
                    //visible: accountMaster_page_controller.FromPage.value == 'Account' ?true:false,
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
                                "Add New Address ",
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
                            Obx((){
                              return Visibility(visible:address_vm_controller.isHeadofficePermission!="1",child: Center(
                                child: IconButton(onPressed: () {
                                  address_vm_controller.clearController();
                                  accountMaster_page_controller.gst_registration_type_controller.value.text = 'UnRegistered';
                                  address_vm_controller.getGeoPostalCodeApi();
                                  Get.toNamed(RoutesName.addNewAddress_screen);
                                },
                                  icon: Icon(Icons.add, size: 40, color: AllColors.textColor,),

                                ),
                              ) );
                            })

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
                        return BindAddressListView(context);
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget BindAddressListView(context) {
    if (address_vm_controller.address_master_list.value.isNotEmpty && address_vm_controller.address_master_list.value.length > 0) {
      ScrollController scrollController = ScrollController();

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (address_vm_controller.total_rows /
              address_vm_controller.rowsPerPage).toInt();
          if ((address_vm_controller.total_rows %
              address_vm_controller.rowsPerPage) >
              0) total_page += 1;

          //print("last index ${accountMaster_page_controller.pageNumber} ${accountMaster_page_controller.total_rows} ${accountMaster_page_controller.rowsPerPage} ${total_page}");

          if (address_vm_controller.pageNumber + 1 < total_page) {
            address_vm_controller.getAddressMasterList(address_vm_controller.pageNumber, address_vm_controller.account_code_controller.text,);
            this.address_vm_controller.pageNumber += 1;
          }
        }
      });

      return ListView.separated(
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => Divider(height: .05, color: Colors.transparent,),
          shrinkWrap: true,
          itemCount: address_vm_controller.address_master_list.value.length,
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
          if(accountMaster_page_controller.FromPage.value == 'Account'){
            address_vm_controller.upDateConsigneeAdd(position);
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
                  "Consignee Id : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message:address_vm_controller.address_master_list[position]
                        .consigneeId?? "",
                    child: Text(
                      address_vm_controller.address_master_list[position]
                          .consigneeId?? "",
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
                  "Address Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Tooltip(
                    message: address_vm_controller.address_master_list[position]
                        .contactName?? "",
                    child: Text(
                      address_vm_controller.address_master_list[position]
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
            /*Row(
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
                    message: address_vm_controller.address_master_list[position]
                        .accountName?? "",
                    child: InkWell(
                      onTap: (){

                      },
                      child: Text(
                        address_vm_controller.address_master_list[position]
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
            ),*/
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
                    message: address_vm_controller.address_master_list[position]
                        .emailId?? "",
                    child: Text(
                      address_vm_controller.address_master_list[position]
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
                    address_vm_controller.address_master_list[position]
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
                  "Ifsc Code : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Text(
                    address_vm_controller.address_master_list[position]
                        .ifscCode ?? "",
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
                  "Address : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: size.width * .55,
                  child: Text("${address_vm_controller.address_master_list[position].address ??""} "
                      "${address_vm_controller.address_master_list[position].city??""} "
                      "${address_vm_controller.address_master_list[position].stateName??""} "
                      "${address_vm_controller.address_master_list[position].postCode??""}",
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

          ],
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
                          controller: address_vm_controller.Consignee_controller.value,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              labelText: 'Consignee Id',
                              hintText: 'Consignee Id',
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

                        TextField(
                          controller: address_vm_controller.contact_name_controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                              labelText: 'Address Name',
                              hintText: 'Address Name',
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
                          controller: address_vm_controller.phone_no_controller,
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

                        TextField(
                          controller: address_vm_controller.emailId_controller,
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
                                  address_vm_controller.getAddressMasterList(address_vm_controller.pageNumber, address_vm_controller.account_code_controller.text);
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
                                  address_vm_controller.contact_name_controller.clear();
                                  address_vm_controller.Consignee_controller.value.clear();
                                  address_vm_controller.phone_no_controller.clear();
                                  address_vm_controller.emailId_controller.clear();

                                  address_vm_controller.getAddressMasterList(address_vm_controller.pageNumber, address_vm_controller.account_code_controller.text);

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

}
