import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/component/circular_loading.dart';
import 'package:navigation_drawer_flutter/constants/static_methods.dart';

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
        contact_vm_controller.pageNumber=0;
        contact_vm_controller.filterIconColor.value=false;
        contact_vm_controller.account_name_controller.clear();
        contact_vm_controller.contact_name_controller.clear();
        contact_vm_controller.depart_name_controller.clear();
        contact_vm_controller.emailId_controller.clear();
        contact_vm_controller.phone_no_controller.clear();
        contact_vm_controller.getContactMasterList(contact_vm_controller.pageNumber, '', '', '');


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
              Obx((){
                return Visibility(
                  //visible: TaskMaster_page_controller.isAdminWritePermission.value == '0'?true:false,
                  visible:contact_vm_controller.isHeadofficePermission.value!="1"  ? true:false ,
                  child: IconButton(onPressed: () {
                    contact_vm_controller.resetAllContactCreativeField('Icon');
                    contact_vm_controller.insideOut = true;
                    //contact_vm_controller.IsHeDecisionMakerController.value.text = "No";
                    contact_vm_controller.getAccountMaster("");
                    contact_vm_controller.getDecisionRoleMaster();
                    Get.toNamed(RoutesName.addNewContactMaster_screen);
                  }, icon: Icon(Icons.add)),
                );
              }),


              Container(
                child: IconButton(onPressed: () {
                  showFilterBottomSheet(context);
                },
                    icon: Icon(Icons.filter_alt_sharp,
                        color: AllColors.whiteColor)),
              )
            ],
          )

      ),
      drawer: CustomDrawer(),
      body:RefreshIndicator(
          onRefresh:contact_vm_controller.refreshList,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Obx((){
                  return Visibility(
                    visible:contact_vm_controller.loading.value /*|| account_vm_controller.loading.value*/ ,
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
        )


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

             SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          bindFilterData(context,'Contact Name',contact_vm_controller.contact_name_controller),
                          SizedBox(height: 5,),
                          bindFilterData(context,'Customer Name',contact_vm_controller.account_name_controller),
                          SizedBox(height: 5,),
                          bindFilterData(context,'Customer Code',contact_vm_controller.account_code_controller),
                          SizedBox(height: 5,),
                          bindFilterData(context,'Email Id',contact_vm_controller.emailId_controller),
                          SizedBox(height: 5,),
                          bindFilterData(context,'Phone No.',contact_vm_controller.phone_no_controller),
                          SizedBox(height: 5,),
                          bindFilterData(context,'Department Name',contact_vm_controller.depart_name_controller),
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(child: _buildButton(
                      text: 'Clear',
                      borderColor: AllColors.redColor,
                      textColor: AllColors.redColor,
                      onTap: () {
                        contact_vm_controller.filterDataChecker.value='';
                        contact_vm_controller.clearFilterData();
                        contact_vm_controller.pageNumber=0;
                        contact_vm_controller.clearAllFilterContoller();
                        contact_vm_controller.getContactMasterList(contact_vm_controller.pageNumber, '', '', '');
                        Get.back();
                      },
                    )),
                    const SizedBox(width: 3,),
                    Expanded(child: _buildButton(
                      text: 'Apply',
                      borderColor: AllColors.primaryDark,
                      textColor: AllColors.primaryDark1,
                      onTap: () {
                        contact_vm_controller.pageNumber=0;
                        contact_vm_controller.getContactMasterList(
                          contact_vm_controller.pageNumber,
                          contact_vm_controller.account_name_controller.text,
                          contact_vm_controller.contact_name_controller.text,
                          contact_vm_controller.depart_name_controller.text,
                        );
                        contact_vm_controller.filterIconColor.value=true;
                        if(contact_vm_controller.account_name_controller.text.isEmpty &&
                            contact_vm_controller.contact_name_controller.text.isEmpty &&contact_vm_controller.depart_name_controller.text.isEmpty){
                          contact_vm_controller.filterIconColor.value=false;
                        }
                        Get.back();
                      },
                    )),
                    const SizedBox(width: 3,),
                    Expanded(child: _buildButton(
                      text: 'Save Filters',
                      borderColor: AllColors.green,
                      textColor: AllColors.green,
                      onTap: () {
                        contact_vm_controller.filterDataChecker.value='';
                        contact_vm_controller.SaveFilterData();
                        Get.back();
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
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

  Widget bindFilterData(BuildContext context,String hintData, TextEditingController controller,){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
          labelText: hintData,
          hintText: hintData,
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

    return Card(
      margin: EdgeInsets.all(5),
      child: ListTile(
        /*onTap: () {
          //accountMaster_page_controller.getAccMasterBuyCodeApi(accountMaster_page_controller.Account_Master_list[position].accountCode);
        },*/
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Contact Code : ",
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Tooltip(
                      message: contact_vm_controller.contact_master_list[position].contactCode?? "",
                      child: Text(contact_vm_controller.contact_master_list[position].contactCode?? "",
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
            Visibility(
              //visible: TaskMaster_page_controller.isAdminWritePermission.value == '0'?true:false,
              visible:contact_vm_controller.isHeadofficePermission.value!="1"  ? true:false ,
              child: InkWell(
                onTap: (){
                  contact_vm_controller.FromPage.value="";
                  contact_vm_controller.insideOut = true;
                  contact_vm_controller.upDateContact('OutSide', position);
                },
                child:Icon(Icons.update) ,
              ),
            ),
            SizedBox(width: 5,),
            Obx(() {
              return Visibility(
                visible: contact_vm_controller.isAdminWritePermission.value == "1" &&
                    contact_vm_controller.isHeadofficePermission.value == "0",
                child: GestureDetector(
                  onTap: () => showConfirmCompleteDialog(context, position!),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              );
            }),

          ],
        ),

        subtitle: Column(
          children: [
           _buildLabelWithValue( "Contact Name : ",contact_vm_controller.contact_master_list[position].contactName?? "" ),
            SizedBox(height: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customer Name : ",
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w500),
                ),
                Flexible(
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
            SizedBox(height: 2,),
            _buildLabelWithValue( "Customer Code : ",contact_vm_controller.contact_master_list[position].accountCode?? "" ),
            SizedBox(height: 2,),

            _buildLabelWithValue( "Email Id : ",contact_vm_controller.contact_master_list[position].emailId?? "" ),
            SizedBox(height: 2),
            _buildLabelWithValue( "Phone No. : ",contact_vm_controller.contact_master_list[position].phoneNo?? "" ),
            SizedBox(height: 2),
            _buildLabelWithValue( "Department Name : ",contact_vm_controller.contact_master_list[position].departmentName?? "" ),
            SizedBox(height: 2),
            _buildLabelWithValue( "Reporting Person : ",contact_vm_controller.contact_master_list[position].reportingPerson?? "" ),
            SizedBox(height: 2),
            _buildLabelWithValue( "Contact Master : ",contact_vm_controller.contact_master_list[position].contactRole ?? "" ),

            SizedBox(height: 2),
            _buildLabelWithValue( "Created By : ",contact_vm_controller.contact_master_list[position].createdFullName?? "" ),
            SizedBox(height: 2),
            _buildLabelWithValue( "Created On : ", StaticMethod.onlyDate(contact_vm_controller.contact_master_list[position].createdOn?? "") ??""),
            SizedBox(height: 2),
            _buildLabelWithValue( "Updated By : ",contact_vm_controller.contact_master_list[position].updatedBy?? "" ),
            SizedBox(height: 2),
            _buildLabelWithValue( "Updated On : ", StaticMethod.onlyDate(contact_vm_controller.contact_master_list[position].updatedOn?? "") ??""),

          ],
        ),

      ),
    );
  }

  Widget _buildLabelWithValue(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontSize: AllFontSize.fourtine,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Tooltip(
            message: value,
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

  showConfirmCompleteDialog(BuildContext context, int index){
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
                    Text("Do You Want to Delete This Contact?",
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
                contact_vm_controller.ContactMstDelete(index);
              },
              child: Text("Delete",style: TextStyle(color: AllColors.greenblue),),
            ),
          ],
        );
      },
    );
  }


}