import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../models/checkInModel/employee_master_model.dart';
import '../../../models/service_managment_model_directory/order_model/order_approval_model.dart';
import '../../../viewModel/service_managment_vm_directory/order_approval_vm/order_approval_vm.dart';
import '../../custom_drawer.dart';

class  OrderApprovalScreen extends StatelessWidget{
  OrderApprovalScreen({super.key});
  
  final order_approval_page_controller=Get.put(OrderApprovalViewModel());
  Size size= Get.size;

  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Order Approval',
          style: GoogleFonts.poppins(
            color: AllColors.whiteColor,
            fontSize: AllFontSize.twentee,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(
          color: AllColors.whiteColor, // Change this to the desired color
        ),
        backgroundColor: AllColors.primaryDark1,
      ),
      drawer: CustomDrawer(),
      body:  Container(
        width: double.infinity,
        height: size.height,
        child: Obx(() {
          if (order_approval_page_controller.loading.value) {
            // Show a progress indicator while loading
            return Center(
              child:
              CircularProgressIndicator(color: AllColors.primaryDark1,), // You can use any progress indicator here
            );
          } else {
            // Show the UI when not loading
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start, // Adjust as needed
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width: (size.width - 20) * 0.40,
                                    child: bindDatePicker(context)),
                                Container(
                                  width: (size.width - 20) * 0.60,
                                  padding: EdgeInsets.only(left: 10),
                                  child: bindemployeeDropDown(context),
                                )
                              ],
                            ),
                          ),
                          //todo like dislike button section
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: TextButton.icon(
                                      label: Text(
                                        "Pending: ${order_approval_page_controller.pending_count}",
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.twelve, color: Colors.blue,fontWeight: FontWeight.w700),
                                      ),
                                      icon: SizedBox.shrink(),//Icon(Icons.pending,),
                                      onPressed: () async {
                                        order_approval_page_controller.selection_type = "";
                                        order_approval_page_controller.getApprovalList('');
                                      },
                                      style: TextButton.styleFrom(
                                        shadowColor: order_approval_page_controller.selection_type == "" ? AllColors.ripple_green : null,
                                        backgroundColor:  order_approval_page_controller.selection_type == "" ? AllColors.ripple_green : null,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextButton.icon(
                                      label: Text(
                                        "Approved: ${order_approval_page_controller.like_count}",
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.twelve, color: AllColors.primaryDark1,fontWeight: FontWeight.w700),
                                      ),
                                      icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
                                      onPressed: () async {
                                        order_approval_page_controller.selection_type = "Approved";
                                        order_approval_page_controller.getApprovalList('');
                                      },
                                      style: TextButton.styleFrom(
                                        shadowColor: order_approval_page_controller.selection_type == "Approved" ? AllColors.ripple_green : null,
                                        backgroundColor:  order_approval_page_controller.selection_type == "Approved" ? AllColors.ripple_green : null,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextButton.icon(
                                      label: Text(
                                        "Rejected: ${order_approval_page_controller.dislike_count}",
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.twelve, color: AllColors.redColor,fontWeight: FontWeight.w700),
                                      ),
                                      icon: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red),
                                      onPressed: () async {
                                        order_approval_page_controller.selection_type = "Rejected";
                                        order_approval_page_controller.getApprovalList('');
                                      },
                                      style: TextButton.styleFrom(
                                        shadowColor: order_approval_page_controller.selection_type == "Rejected" ? AllColors.ripple_green : null,
                                        backgroundColor:  order_approval_page_controller.selection_type == "Rejected" ? AllColors.ripple_green : null,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),

                               bindListLayout()


                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),

    );
  }

  Widget bindListLayout() {
    if(order_approval_page_controller.approver_list_data==null || order_approval_page_controller.approver_list_data.isEmpty){
      return Container(
        child: Center(
          child:Image.asset("assests/images/no_data_remove.png",width: 300,height: 180,),
        ),
      );
    }else{
      Size size = Get.size;
      return Container(
        height: size.height*.7,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),
            itemCount: order_approval_page_controller.approver_list_data.length,
            itemBuilder: (context, index) {
              var item = order_approval_page_controller.approver_list_data[index];
              return   BindListView(context, item, index);
            }),
      );
    }
  }

  //todo listview bind
  Widget BindListView(context, OrderApprovalModel item, int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
           order_approval_page_controller.getOrderHeaderDetails(item.orderNo!);
        },
        title:  Text("Order : ${item.orderNo!} ",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.fourtine,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.customerName!,style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twelve,fontWeight: FontWeight.w300
            ),),
            Text("Qty: ${item.totalQty.toString()}" ,
                style: GoogleFonts.poppins(
                  color: AllColors.blackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.twelve,
                )),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( order_approval_page_controller.selection_type== "Rejected"?"Rej. Qty: ${item.totalApproveQty.toString()}":
                "App.Qty: ${item.totalApproveQty.toString()}" ,
                    style: GoogleFonts.poppins(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.twelve,
                    )),

                Text(" ${item.orderDate!}" ,
                    style: GoogleFonts.poppins(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.twelve,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Created By :" ,
                    style: GoogleFonts.poppins(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.twelve,
                    )),

                Container(
                  width: size.width*0.3,
                  child: Tooltip(
                    message: item.createdBy.toString(),
                    child: Text(" ${item.createdBy!}" ,
                      style: GoogleFonts.poppins(
                        color: AllColors.blackColor,
                        fontWeight: FontWeight.w300,
                        fontSize: AllFontSize.twelve,
                      ),
                      overflow: TextOverflow.ellipsis,),
                  ),
                ),
              ],
            ),

          ],
        ),
        leading: bindAvatar(item),
        //trailing: likeDislikeIconButtonUi(item),
      ),
    );
  }


  //todo list view left icon bind
  Widget bindAvatar(OrderApprovalModel item) {
    if (item.imageUrl != null && item.imageUrl != "")
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
              backgroundImage: NetworkImage(item.imageUrl.toString())),
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

  //todo date picker
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: order_approval_page_controller.filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
        DateTime ending_date = new DateTime(2200);
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: stating_date,
          lastDate: ending_date,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AllColors.primaryDark1, // Header background color
                //accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },

        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          order_approval_page_controller.filter_date_controller.text =
              outputFormat.format(date);
        else
          order_approval_page_controller.filter_date_controller.text = "";

        order_approval_page_controller.getApprovalList('');
      },
    );
  }

  //todo employee dropdown

  /*Widget bindemployeeDropDown(context) {
    return TextField(
      cursorColor: AllColors.primaryDark1,
      controller: order_approval_page_controller.employee_controller,
      focusNode: FocusNode(),
      onChanged: (value) {
        // order_approval_page_controller.getApprovalList(value);
      },
      onSubmitted: (value){
        order_approval_page_controller.getApprovalList(value);
      },
      //autofocus: true,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Search......',
        labelText: 'Created By',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
    );
  }*/



  //todo employee dropdown
  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return order_approval_page_controller.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return order_approval_page_controller.employess_List
            .where((EmpMasterResponse option) {
          return option.loginEmailId
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (EmpMasterResponse selection) {
        print(selection.loginEmailId);
        // Update the TextField with the selected
        order_approval_page_controller.employee_controller.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller..text=order_approval_page_controller.employee_controller.text,
          focusNode: focusNode,
          onChanged: (value){
            if(value.isEmpty){
              order_approval_page_controller.employee_controller.text='';
            }
          },

          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Employee',
            labelText: 'Employee',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten
            ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<EmpMasterResponse> onSelected,
          Iterable<EmpMasterResponse> suggestions) {
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
                  final EmpMasterResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.loginEmailId.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen// Change the text color here
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