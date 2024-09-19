import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/viewModel/user_expense_vm/user_expense_vm.dart';
import 'dart:io';
import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/service_managment_model_directory/regionModel/region_model.dart';
import '../../models/user_expense_model/category_response.dart';
import '../../reources/routes/routes_name.dart';
import '../custom_drawer.dart';

class CreateExpenseScreen extends StatelessWidget{
  CreateExpenseScreen({super.key});
  Size size=Get.size;
  final createExpense_page_controller=Get.put(UserExpenseViewModel());
  static String _displaycategoryForOption(CatagoryResponse option) =>
      option.expenseName!;
  static String _displayRegionForOption(RegionModel option) =>
      option.regionName!;

  @override
  Widget build(BuildContext context) {
   return  WillPopScope(
     onWillPop: ()  async {
       Get.toNamed(RoutesName.myExpenseScreen);
       return false;
     },
     child: Scaffold(
       appBar: AppBar(
         title: Row(
           children: [
             Text(
               'Create Expense',
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
           child: Column(
             children: [

               Obx((){
                 return Visibility(
                   visible: createExpense_page_controller.isPogressIndicator.value?true:false,
                   child: Container(
                     margin: EdgeInsets.only(top: 1),
                     child: LinearProgressIndicator(
                       backgroundColor: AllColors.primaryDark1,
                       color: AllColors.primaryliteColor,
                     ),
                     /* child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.ripple_green,
                        minHeight: 5,
                        value: 0,
                      ),*/
                   ),
                 );
               }),

               Expanded(
                 child: ListView(
                   padding: EdgeInsets.only(left: 20,right: 20,top: 12),
                   shrinkWrap: true,
                   children: <Widget>[
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         TextFormField(
                           controller: createExpense_page_controller.description_controller,
                           onChanged: (value) {
                             createExpense_page_controller.description_controller.value;
                           },
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
                             hintText: "Reason of expenses",
                             labelText: "Description",
                             hintStyle: GoogleFonts.poppins(
                               color: AllColors.lightblackColor,
                               fontWeight: FontWeight.w300,
                               fontSize: AllFontSize.ten,
                             ),
                             labelStyle: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontWeight: FontWeight.w700,
                               fontSize: AllFontSize.sisxteen,
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
                             ),
                           ),
                           cursorColor: AllColors.primaryDark1,
                         ),
                         SizedBox(height: 8),
                         bindDatePicker(context),
                         SizedBox(height: 8),
                         Obx(() {
                           return Visibility(visible: createExpense_page_controller.iscategoryExpense.value,
                             child:bindCatagoryDropDown(context),
                           );

                           //return //bindCatagoryDropDown(context);
                         }),

                         SizedBox(height: 8),
                         //todo for todate from
                         Obx((){
                           return Visibility(
                             visible: createExpense_page_controller.isLodging>0 ? true :false,
                             child: Column(
                               children: [
                                 bindDatePickerFrom(context),
                                 SizedBox(height: 8),
                                 bindDatePickerTo(context),
                                 SizedBox(height: 8),
                                 bindRegionNameDropDown(context),
                                 SizedBox(height: 8),
                                 if(createExpense_page_controller.isKm>0) bindTotalKm(context),
                               ],
                             ),
                           );
                         }),
                         SizedBox(height: 8),
                         TextFormField(
                           controller: createExpense_page_controller.amount_controller,
                           keyboardType: TextInputType.number,
                           onChanged: (value) {
                             createExpense_page_controller.amount_controller.value;
                           },
                           decoration: InputDecoration(
                             hintText: "Amount of expense with all taxes",
                             labelText: "Total Amount",

                             hintStyle: GoogleFonts.poppins(
                               color: AllColors.lightblackColor,
                               fontWeight: FontWeight.w300,
                               fontSize: AllFontSize.ten,
                             ),
                             labelStyle: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontWeight: FontWeight.w700,
                               fontSize: AllFontSize.sisxteen,
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
                             ),
                           ),
                           cursorColor: AllColors.primaryDark1,
                         ),
                         SizedBox(height: 8),
                         TextFormField(
                           controller: createExpense_page_controller.remark_controller,
                           keyboardType: TextInputType.text,
                           onChanged: (value) {
                             createExpense_page_controller.remark_controller.value;
                           },
                           decoration: InputDecoration(
                             hintText: "Remark",
                             labelText: "Remark",
                             hintStyle: GoogleFonts.poppins(
                               color: AllColors.lightblackColor,
                               fontWeight: FontWeight.w300,
                               fontSize: AllFontSize.ten,
                             ),
                             labelStyle: GoogleFonts.poppins(
                               color: AllColors.primaryDark1,
                               fontWeight: FontWeight.w700,
                               fontSize: AllFontSize.sisxteen,
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
                             ),
                           ),
                           cursorColor: AllColors.primaryDark1,
                         ),
                         SizedBox(height: size.height*.05),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             //todo when page load then loading close and obx comment (Ritik)....
                             /* Obx(() {
                                  return*/ Expanded(
                               child: DefaultButton(
                                 text: "Submit",
                                 press: () {
                                   createExpense_page_controller.expenseCreateApi();
                                   // loading: createExpense_page_controller.loading.value=false;
                                 },
                                 //  loading: createExpense_page_controller.loading.value,

                               ),
                             ),
                             //}),
                             SizedBox(width: size.width*.01),
                             Expanded(
                               child: DefaultButton(
                                 text: "Reset",
                                 press: () {
                                   createExpense_page_controller.resetAllFields();
                                 },
                                 //loading: createExpense_page_controller.loading.value,
                               ),
                             ),
                             SizedBox(width: size.width*.01),
                             GestureDetector(
                                 onTap:() async{
                                   FocusScopeNode currentFocus = FocusScope.of(context);
                                   if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                     currentFocus.focusedChild?.unfocus();
                                   }
                                   if(createExpense_page_controller.isShowImage.value==true)
                                     createExpense_page_controller.isShowImage.value=false;
                                   else
                                     createExpense_page_controller.isShowImage.value=true;

                                 },
                                 child: Icon(Icons.attach_file,color: AllColors.lightblackColor,)), // Replace with your desired attachment icon
                             SizedBox(width: size.width*.01), // Add spacing between the icon and text
                             Obx(() {
                               return Text(createExpense_page_controller.imageCount.toString(),
                                 style: GoogleFonts.poppins(
                                   color: AllColors.lightblackColor,
                                   fontSize: AllFontSize.sisxteen,
                                   fontWeight: FontWeight.w700,
                                 ),
                               );
                             }),
                           ],
                         ),
                         SizedBox(height: size.height*0.02,),
                         Obx((){
                           return Visibility(
                             visible: createExpense_page_controller.isShowImage.value,
                             child: Column(children: [
                               Row(
                                 children: [
                                   Expanded(
                                     child: Container(
                                       height: 1, // Adjust the height of the line as needed
                                       color: Colors.black, // Change the color of the line
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                     child: Text(
                                       "Files",
                                       style: GoogleFonts.poppins(
                                           fontSize: AllFontSize.sisxteen, // Adjust the font size
                                           fontWeight: FontWeight.w700,
                                           color: AllColors.lightblackColor// Adjust the font weight
                                       ),
                                     ),
                                   ),
                                   Expanded(
                                     child: Container(
                                       height: 1, // Adjust the height of the line as needed
                                       color: Colors.black, // Change the color of the line
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: size.height*0.02,),
                               SingleChildScrollView(
                                 scrollDirection: Axis.horizontal,
                                 child: Center(
                                   child: Row(
                                     children: [
                                       GestureDetector(
                                         child: Container(
                                           child: DottedBorder(
                                             color: Colors.grey,
                                             strokeWidth: 2,
                                             borderType: BorderType.RRect,
                                             radius: Radius.circular(20),
                                             dashPattern: [10, 5, 10, 5],
                                             child: Container(
                                               width: size.width * 0.30,
                                               height: size.height * 0.15,
                                               child: createExpense_page_controller.file_path0.isNotEmpty
                                                   ? (createExpense_page_controller.file_path0.toLowerCase().endsWith('.png')
                                                   || createExpense_page_controller.file_path0.toLowerCase().endsWith('.jpeg')
                                                   || createExpense_page_controller.file_path0.toLowerCase().endsWith('.jpg'))
                                                   ? ClipRRect(
                                                 borderRadius: BorderRadius.circular(20.0),
                                                 child: Image.file(
                                                   File(createExpense_page_controller.file_path0.toString()),
                                                   fit: BoxFit.cover,
                                                 ),
                                               ): createExpense_page_controller.file_path0.isNotEmpty &&  createExpense_page_controller.file_path0.toLowerCase().endsWith('.pdf')
                                                   ? Icon(
                                                 Icons.picture_as_pdf,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.file_copy,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.image,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ),
                                             ),
                                           ),
                                         ),
                                         onTap:  ()async{
                                           //  await createExpense_page_controller.getFile('file_one');
                                         },
                                       ),
                                       SizedBox(width: size.width*.02),
                                       GestureDetector(
                                         child: Container(
                                           child: DottedBorder(
                                             color: Colors.grey,
                                             strokeWidth: 2,
                                             borderType: BorderType.RRect,
                                             radius: Radius.circular(20),
                                             dashPattern: [10, 5, 10, 5],
                                             child: Container(
                                               width: size.width * 0.30,
                                               height: size.height * 0.15,
                                               child: createExpense_page_controller.file_path1.isNotEmpty
                                                   ? (createExpense_page_controller.file_path1.toLowerCase().endsWith('.png')
                                                   || createExpense_page_controller.file_path1.toLowerCase().endsWith('.jpeg')
                                                   || createExpense_page_controller.file_path1.toLowerCase().endsWith('.jpg'))
                                                   ? ClipRRect(
                                                 borderRadius: BorderRadius.circular(20.0),
                                                 child: Image.file(
                                                   File(createExpense_page_controller.file_path1.toString()),
                                                   fit: BoxFit.cover,
                                                 ),
                                               ): createExpense_page_controller.file_path1.isNotEmpty &&  createExpense_page_controller.file_path1.toLowerCase().endsWith('.pdf')
                                                   ? Icon(
                                                 Icons.picture_as_pdf,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.file_copy,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.image,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ),
                                             ),
                                           ),
                                         ),
                                         onTap:  ()async{
                                           // await createExpense_page_controller.getFile('file_two');
                                         },
                                       ),
                                       SizedBox(width: size.width*.02),
                                       GestureDetector(
                                         child: Container(
                                           child: DottedBorder(
                                             color: Colors.grey,
                                             strokeWidth: 2,
                                             borderType: BorderType.RRect,
                                             radius: Radius.circular(20),
                                             dashPattern: [10, 5, 10, 5],
                                             child: Container(
                                               width: size.width * 0.30,
                                               height: size.height * 0.15,
                                               child: createExpense_page_controller.file_path2.isNotEmpty
                                                   ? (createExpense_page_controller.file_path2.toLowerCase().endsWith('.png')
                                                   || createExpense_page_controller.file_path2.toLowerCase().endsWith('.jpeg')
                                                   || createExpense_page_controller.file_path2.toLowerCase().endsWith('.jpg'))
                                                   ? ClipRRect(
                                                 borderRadius: BorderRadius.circular(20.0),
                                                 child: Image.file(
                                                   File(createExpense_page_controller.file_path2.toString()),
                                                   fit: BoxFit.cover,
                                                 ),
                                               ): createExpense_page_controller.file_path2.isNotEmpty &&  createExpense_page_controller.file_path2.toLowerCase().endsWith('.pdf')
                                                   ? Icon(
                                                 Icons.picture_as_pdf,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.file_copy,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.image,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ),
                                             ),
                                           ),
                                         ),
                                         onTap:  ()async{
                                           //await createExpense_page_controller.getFile('file_three');
                                         },
                                       ),
                                       SizedBox(width: size.width*.02),
                                       GestureDetector(
                                         child: Container(
                                           child: DottedBorder(
                                             color: Colors.grey,
                                             strokeWidth: 2,
                                             borderType: BorderType.RRect,
                                             radius: Radius.circular(20),
                                             dashPattern: [10, 5, 10, 5],
                                             child: Container(
                                               width: size.width * 0.30,
                                               height: size.height * 0.15,
                                               child: createExpense_page_controller.file_path3.isNotEmpty
                                                   ? (createExpense_page_controller.file_path3.toLowerCase().endsWith('.png')
                                                   || createExpense_page_controller.file_path3.toLowerCase().endsWith('.jpeg')
                                                   || createExpense_page_controller.file_path3.toLowerCase().endsWith('.jpg'))
                                                   ? ClipRRect(
                                                 borderRadius: BorderRadius.circular(20.0),
                                                 child: Image.file(
                                                   File(createExpense_page_controller.file_path3.toString()),
                                                   fit: BoxFit.cover,
                                                 ),
                                               ): createExpense_page_controller.file_path3.isNotEmpty &&  createExpense_page_controller.file_path3.toLowerCase().endsWith('.pdf')
                                                   ? Icon(
                                                 Icons.picture_as_pdf,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.file_copy,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ):Icon(
                                                 Icons.image,
                                                 size: 60,
                                                 color: AllColors.primaryDark1,
                                               ),
                                             ),
                                           ),
                                         ),
                                         onTap:  ()async{
                                           // await createExpense_page_controller.getFile('file_four');
                                         },
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                               SizedBox(height: size.height*0.02,),
                               Visibility(
                                 visible: createExpense_page_controller.addFileButton.value,
                                 child: GestureDetector(
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Container(
                                         decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                             color: AllColors.primaryDark1
                                         ),
                                         child: Icon(Icons.add,color: AllColors.whiteColor,),
                                       ),
                                       SizedBox(width: size.width*.02,),
                                       Text('Add Files',
                                         style: GoogleFonts.poppins(
                                           color: AllColors.primaryDark1,
                                           fontWeight: FontWeight.w700,
                                           fontSize: AllFontSize.twentee,
                                         ),
                                       )
                                     ],
                                   ),
                                   onTap: ()async{
                                     showCinfirmationDialog(context);
                                     //await createExpense_page_controller.getFile('');
                                   },
                                 ),
                               )
                             ],
                             ),
                           );
                         }),

                       ],
                     ),

                   ],
                 ),
               )
             ],
           )
       ),
     ),
   );
  }

  Widget bindDatePicker(context) {
    return TextFormField(
      // ... (your existing code)
      controller: createExpense_page_controller.date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Expense Date",
        labelText: 'Date',
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
        DateTime startingDate = DateTime(1900);
        //DateTime endingDate = DateTime(2200);
        DateTime endingDate = DateTime.now();
        FocusScope.of(context).requestFocus(new FocusNode());

        DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: startingDate,
            lastDate: endingDate,
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
            }
        );

        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "") {
          createExpense_page_controller.date_controller.text = outputFormat.format(date);
        } else {
          createExpense_page_controller.date_controller.text = "";
        }
      },
    );
  }

  Widget bindDatePickerFrom(context) {
    return TextFormField(
      controller: createExpense_page_controller.from_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "From Date",
        labelText: 'From Date',
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
        //DateTime ending_date = new DateTime(2200);
        DateTime ending_date = new DateTime.now();
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
            }
        );

        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          createExpense_page_controller.from_date_controller.text =
              outputFormat.format(date);
        else
          createExpense_page_controller.from_date_controller.text = "";

      },
    );
  }

  void showCinfirmationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Choose Option.....",
            style: TextStyle(color: AllColors.primaryDark1,)),
        content: Container(
         // height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(height: .5, color: AllColors.lightgreyColor,),
              GestureDetector(
                onTap: () async {
                  await createExpense_page_controller.getFile('');
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.photo_album_outlined,
                        color: AllColors.primaryDark1, size: 20,),
                      SizedBox(width: 20,),
                      Text('Gallery', style: TextStyle(color: AllColors
                          .primaryDark1),),
                    ],
                  ),
                ),
              ),
              Divider(height: .5, color: AllColors.lightgreyColor,),
              InkWell(
                onTap: () async {
                  createExpense_page_controller.upLoadImage(context, '');
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined,
                        color: AllColors.primaryDark1, size: 20,),
                      SizedBox(width: 20,),
                      Text('Camera', style: TextStyle(color: AllColors
                          .primaryDark1),),
                    ],
                  ),
                ),
              ),
              Divider(height: .5, color: AllColors.lightgreyColor,),
            ],
          ),
        ),
      );
    });
  }


  //todo employee dropdown
  Widget bindCatagoryDropDown(context) {
    return Autocomplete<CatagoryResponse>(
      displayStringForOption: _displaycategoryForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return createExpense_page_controller.expense_catagory_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return createExpense_page_controller.expense_catagory_list
            .where((CatagoryResponse option) {
          return option.expenseName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CatagoryResponse selection) {
        createExpense_page_controller.getRegionsList();
        print(selection.expenseName);
        // Update the TextField with the selected
        createExpense_page_controller.expense_catagory_controller.text =
            _displaycategoryForOption(selection).toString();
        createExpense_page_controller.image_requred.value = selection.imageRequired!;
        createExpense_page_controller.isLodging.value = selection.isLodging!;
        createExpense_page_controller.isKm.value = selection.isKm!;
        print(createExpense_page_controller.image_requred.value);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller..text=createExpense_page_controller.expense_catagory_controller.text,
          focusNode: focusNode,
          cursorColor: AllColors.primaryDark1,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Category',
            labelText: 'Expense Category',
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
          AutocompleteOnSelected<CatagoryResponse> onSelected,
          Iterable<CatagoryResponse> suggestions) {
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
                  final CatagoryResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.expenseName.toString(),
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

  Widget bindDatePickerTo(context) {
    return TextFormField(
      controller: createExpense_page_controller.to_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "To Date",
        labelText: 'To Date',
        hintStyle: GoogleFonts.poppins(
          color: AllColors.lightblackColor,
          fontWeight: FontWeight.w300,
          fontSize: AllFontSize.ten,
        ),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontWeight: FontWeight.w700,
          fontSize: AllFontSize.sisxteen,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1),
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime starting_date = DateTime(1900);
        DateTime ending_date = DateTime.now();
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: starting_date,
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
        if (date != null && date != "") {
          createExpense_page_controller.to_date_controller.text = outputFormat.format(date);
        } else {
          createExpense_page_controller.to_date_controller.text = "";
        }
      },
    );
  }

  Widget bindRegionNameDropDown(context) {
    return Autocomplete<RegionModel>(
      displayStringForOption: _displayRegionForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return createExpense_page_controller.region_name_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return createExpense_page_controller.region_name_list
            .where((RegionModel option) {
          return option.regionName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (RegionModel selection) {
        print(selection.regionName);
        // Update the TextField with the selected
        createExpense_page_controller.region_catagory_controller.text =
            _displayRegionForOption(selection).toString();
        createExpense_page_controller.region_name.value = selection.regionName!;
        createExpense_page_controller.region_code.value = selection.regionCode!;
        print(createExpense_page_controller.region_code.value);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller..text=createExpense_page_controller.region_catagory_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Region',
            labelText: 'Region Name',
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
          AutocompleteOnSelected<RegionModel> onSelected,
          Iterable<RegionModel> suggestions) {
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
                  final RegionModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(option.regionName.toString()!=null? option.regionName.toString():"",
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
  Widget bindTotalKm(context){
    return TextFormField(
      controller: createExpense_page_controller.total_km_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        createExpense_page_controller.total_km_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Total Km.",
        labelText: "Total Km.",

        hintStyle: GoogleFonts.poppins(
          color: AllColors.lightblackColor,
          fontWeight: FontWeight.w300,
          fontSize: AllFontSize.ten,
        ),
        labelStyle: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontWeight: FontWeight.w700,
          fontSize: AllFontSize.sisxteen,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

}