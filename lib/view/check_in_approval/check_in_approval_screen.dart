import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/checkInModel/employee_master_model.dart';
import '../../models/check_in_approval_model/check_in_approval_entity_model.dart';
import '../../viewModel/checkIin_approval_vm/checkin_approval_vm.dart';
import '../custom_drawer.dart';

class CheckInApprovalScreen extends StatelessWidget{
 CheckInApprovalScreen({super.key});
 final checkApproval_page_controller=Get.put(CheckInApprovalViewModel());
 static String _displayemployeeForOption(EmpMasterResponse option) =>
         option.loginEmailId!;
     Size size=Get.size;
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: () async {
       Get.offAllNamed(RoutesName.homeScreen);
       return false;
     },
     child: Scaffold(
       appBar: AppBar(
         title: Row(
           children: [
             Text(
               'Check In Approval List',
               style: GoogleFonts.poppins(
                 color: AllColors.whiteColor,
                 fontSize: AllFontSize.twentee,
                 fontWeight: FontWeight.w700,
               ),
             ),
           ],
         ),
         iconTheme: IconThemeData(
           color: AllColors.whiteColor, // Change this to the desired color
         ),
         backgroundColor: AllColors.primaryDark1,
       ),
       drawer: CustomDrawer(),
       backgroundColor: Colors.white,
       body: Container(
         width: double.infinity,
         height: size.height,
         child: Obx(() {
           if (checkApproval_page_controller.loading.value) {
             // Show a progress indicator while loading
             return Center(
               child:
               CircularProgressIndicator(color: AllColors.primaryDark1), // You can use any progress indicator here
             );
           } else {
             // Show the UI when not loading
             return Column(
               children: [

                 Expanded(
                   child: SingleChildScrollView(
                     child: Container(
                       padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                       child: Column(
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
                                   //child: bindEmployeeDropDown(context),
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
                                         "Pending : ${checkApproval_page_controller.pending_count}",
                                         style: GoogleFonts.poppins(
                                             fontSize: AllFontSize.twelve, color: Colors.blue,fontWeight: FontWeight.w700),
                                       ),
                                       icon: SizedBox.shrink(),//Icon(Icons.pending,),
                                       onPressed: () async {
                                         checkApproval_page_controller.selection_type = "";
                                         checkApproval_page_controller.getApprovalList();
                                       },
                                       style: TextButton.styleFrom(
                                         shadowColor: checkApproval_page_controller.selection_type == "" ? AllColors.ripple_green : null,
                                         backgroundColor:  checkApproval_page_controller.selection_type == "" ? AllColors.ripple_green : null,
                                       ),
                                     ),
                                   ),
                                   Flexible(
                                     child: TextButton.icon(
                                       label: Text(
                                         "Approved : ${checkApproval_page_controller.like_count}",
                                         style: GoogleFonts.poppins(
                                             fontSize: AllFontSize.twelve, color: AllColors.primaryDark1,fontWeight: FontWeight.w700),
                                       ),
                                       icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
                                       onPressed: () async {
                                         checkApproval_page_controller.selection_type = "Like";
                                         checkApproval_page_controller.getApprovalList();
                                       },
                                       style: TextButton.styleFrom(
                                         shadowColor: checkApproval_page_controller.selection_type == "Like"? AllColors.ripple_green : null,
                                         backgroundColor: checkApproval_page_controller.selection_type == "Like" ? AllColors.ripple_green : null,
                                       ),
                                     ),
                                   ),
                                   Flexible(
                                     child: TextButton.icon(
                                       label: Text(
                                         "Rejected : ${checkApproval_page_controller.dislike_count}",
                                         style: GoogleFonts.poppins(
                                             fontSize: AllFontSize.twelve, color: AllColors.redColor,fontWeight: FontWeight.w700),
                                       ),
                                       icon:SizedBox.shrink(), //Icon(Icons.thumb_down, color: Colors.red),
                                       onPressed: () async {
                                         checkApproval_page_controller.selection_type =
                                         "Dislike";
                                         checkApproval_page_controller.getApprovalList();
                                       },
                                       style: TextButton.styleFrom(
                                         shadowColor: checkApproval_page_controller.selection_type == "Dislike" ? AllColors.ripple_green : null,
                                         backgroundColor:  checkApproval_page_controller.selection_type == "Dislike" ? AllColors.ripple_green : null,
                                       ),
                                     ),
                                   ),
                                 ]),
                           ),
                           bindListLayout(),
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
     ),
   );
  }


     Widget bindListLayout() {
       if(checkApproval_page_controller.approver_list_data==null || checkApproval_page_controller.approver_list_data.isEmpty){
         return Container(
           padding: EdgeInsets.all(10),
           child: Text('No Records Found.',style: TextStyle(
               fontSize: 20,
               color: AllColors.primaryDark1
           ),),
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
               itemCount: checkApproval_page_controller.approver_list_data.length,
               itemBuilder: (context, index) {
                 var item = checkApproval_page_controller.approver_list_data[index];
                 return BindListView(context, item, index);
               }),
         );
       }

     }

     //todo listview bind
     Widget BindListView(context, CheckInApproveEntity item, int position) {
       var orderDate = StaticMethod.dateTimeToDate(item.completed_on!);
       return InkWell(
         child: ListTile(
           onTap: () {
             if (checkApproval_page_controller.selection_type == "") {
               //_showGenderSelectionDialog(context, item);
               checkApproval_page_controller.currentRunningCheckInData(context,item.documentNo!);
             }
             else{
               checkApproval_page_controller.currentRunningCheckInData(context,item.documentNo!);
             }
           },
           title: Text('${item.documentNo!}${' ('}${item.empName!})',style: GoogleFonts.poppins(
               color: AllColors.blackColor,
               fontSize: AllFontSize.fourtine,fontWeight: FontWeight.w500
           ),),
           subtitle: Text("${item.placeToVisit!} ( ${orderDate.toString()} )",
               style: GoogleFonts.poppins(
                 color: AllColors.blackColor,
                 fontWeight: FontWeight.w300,
                 fontSize: AllFontSize.twelve,
               )),
           leading: bindAvatar(item),
           trailing: likeDislikeIconButtonUi(item),
         ),
       );
     }
     //todo list view left icon bind
     Widget bindAvatar(CheckInApproveEntity item) {
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
               backgroundImage: AssetImage("assets/images/no_file.png"),
             ),
           ),
         );
     }

     //todo listview right icon bind
     Widget likeDislikeIconButtonUi(CheckInApproveEntity item) {
       if (checkApproval_page_controller.selection_type == "Like") {
         return Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Container(
               height: 24,
               width: 24,
               child: IconButton(
                 iconSize: 24,
                 icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
                 onPressed: () {
                   // Handle the top icon button tap
                 },
                 splashColor: Colors.transparent,
                 // Set the splash color to transparent
                 highlightColor: Colors.transparent,
               ),
             )
           ],
         );
       }
       if (checkApproval_page_controller.selection_type == "Dislike") {
         return Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               height: 24,
               width: 24,
               child: IconButton(
                 iconSize: 24,
                 icon: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red,),
                 onPressed: () {
                   // Handle the top icon button tap
                 },
                 splashColor: Colors.transparent,
                 // Set the splash color to transparent
                 highlightColor: Colors.transparent,
               ),
             )
           ],
         );
       }

       return Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Container(
             height: 24,
             width: 24,
             child: IconButton(
               iconSize: 24,
               icon: SizedBox.shrink(),//Icon(Icons.thumb_up),
               onPressed: () {
                 // Handle the top icon button tap
               },
               splashColor: Colors.transparent,
               // Set the splash color to transparent
               highlightColor: Colors.transparent,
             ),
           ),
           Container(
             height: 24,
             width: 24,
             child: IconButton(
               iconSize: 24,
               icon: SizedBox.shrink(),//Icon(Icons.thumb_down),
               onPressed: () {
                 // Handle the top icon button tap
               },
               splashColor: Colors.transparent,
               // Set the splash color to transparent
               highlightColor: Colors.transparent,
             ),
           ),
         ],
       );
     }



     //todo date picker
     Widget bindDatePicker(context) {
       return TextFormField(
         controller: checkApproval_page_controller.filter_date_controller,
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
             checkApproval_page_controller.filter_date_controller.text =
                 outputFormat.format(date);
           else
             checkApproval_page_controller.filter_date_controller.text = "";

           checkApproval_page_controller.getApprovalList();
         },
       );
     }

     //todo employee dropdown
     Widget bindemployeeDropDown(context) {
       return Autocomplete<EmpMasterResponse>(
         displayStringForOption: _displayemployeeForOption,
         optionsBuilder: (TextEditingValue textEditingValue) {
           if (textEditingValue.text.isEmpty) {
             return checkApproval_page_controller.employess_List;
             // return const Iterable<VehicleTypeResponse>.empty();
           }
           return checkApproval_page_controller.employess_List
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
           checkApproval_page_controller.typeAheadControllerEmployee.text =
               _displayemployeeForOption(selection).toString();
         },
         fieldViewBuilder: (BuildContext context, TextEditingController controller,
             FocusNode focusNode, VoidCallback onFieldSubmitted) {
           return TextField(
             cursorColor: AllColors.primaryDark1,
             controller: controller..text=checkApproval_page_controller.typeAheadControllerEmployee.text,
             focusNode: focusNode,
             //onSubmitted: onFieldSubmitted,
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