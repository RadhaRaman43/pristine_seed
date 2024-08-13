import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../viewModel/CheckIn_vm/check_in_vm.dart';
import '../custom_drawer.dart';

class AddExpanseScreen extends StatelessWidget{
  AddExpanseScreen({super.key});
  final CheckInViewModel addExpenses_page_controller = Get.put(CheckInViewModel());
  Size size=Get.size;
  var date = '';
  @override
  Widget build(BuildContext context) {
    List<String> dateTimeParts =
    addExpenses_page_controller.current_checkIn_response[0].createdOn!.split('T');
    date = dateTimeParts[0];
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AllColors.primaryDark1,
        iconTheme: IconThemeData(
          color: AllColors.whiteColor,
        ),
        title:Text(
          'Add Expense',
          style: GoogleFonts.poppins(
            color: AllColors.whiteColor,
            fontSize: AllFontSize.twentee,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body:  Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.white70, width: .5),
                    ),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "Expense Date :",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              date,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "Visited Place :",
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                addExpenses_page_controller
                                    .current_checkIn_response[0].placeToVisit
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Travelling Mode :",
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                addExpenses_page_controller
                                    .current_checkIn_response[0].vehileType
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Total Km :",
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                addExpenses_page_controller
                                    .current_checkIn_response[0].totalKm
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Travelling Amount :",
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                'Rs. ${addExpenses_page_controller.current_checkIn_response[0].travellingAmount.toString()}',
                                style: GoogleFonts.poppins(
                                    color: AllColors.redColor,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Checkbox(
                    value: addExpenses_page_controller.isAddExpense.value,
                    activeColor: AllColors.primaryDark1,
                    onChanged: (value) {
                      addExpenses_page_controller.isAddExpense.value =
                          value ?? false;
                    },
                  );
                }),
                Text(
                  'Add Expenses',
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(width: size.width*.2,),
                Expanded(
                  child: DefaultButton(
                    text: "Complete",
                    press: () {
                      addExpenses_page_controller.checkOutComplete();
                    },
                    loading: addExpenses_page_controller.loading.value,
                  ),
                ),
                SizedBox(
                  width: size.width * .02,
                )
              ],
            ),
            Obx(() {
              return Visibility(
                visible: addExpenses_page_controller.isAddExpense.value,
                child: Column(
                  children: [
                    Divider(
                      color: AllColors.blackColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Expenses",
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.fourtine),
                          ),

                          Text(
                            '\u{20B9} ${addExpenses_page_controller.current_checkIn_response[0].totalLineAmount! > 0 ? addExpenses_page_controller.current_checkIn_response[0].totalLineAmount.toString() : "0.0"}',
                            style: GoogleFonts.poppins(
                                color: AllColors.lightblackColor,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700),
                          ),

                        ],
                      ),
                    ),
                    Divider(
                      color: AllColors.blackColor,
                    ),
                  ],
                ),
              );
            }),

            Obx(
                  () => Visibility(
                visible: addExpenses_page_controller.isAddExpense.value,
                child: Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => Divider(
                      height: 0,
                      color: AllColors.whiteColor,
                    ),
                    itemCount: addExpenses_page_controller
                        .current_checkIn_response[0].lines!.length,
                    itemBuilder: (context, index) => itemsWidget(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }


  Widget itemsWidget(int index) {
    TextEditingController expenseController = TextEditingController();

    expenseController.text = addExpenses_page_controller
        .current_checkIn_response[0].lines![index].expenseAmount! >
        0
        ? addExpenses_page_controller
        .current_checkIn_response[0].lines![index].expenseAmount
        .toString()
        : "";
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * .5,
                    child: Text(
                        addExpenses_page_controller.current_checkIn_response[0]
                            .lines![index].expenseName
                            .toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w700)),
                  ),
                  Container(
                      width: size.width * 0.2,
                      child: Text(
                        '\u{20B9} ${addExpenses_page_controller.current_checkIn_response[0].lines![index].expenseAmount! > 0 ? addExpenses_page_controller.current_checkIn_response[0].lines![index].expenseAmount.toString() : "0.0"}',
                        style: GoogleFonts.poppins(
                            color: AllColors.lightblackColor,
                            fontSize: AllFontSize.sisxteen,
                            fontWeight: FontWeight.w700),
                      )),

                  SizedBox(
                    width: size.width * 0.1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.attachment,
                          size: 20,
                          color: AllColors.lightblackColor,
                        ),
                        SizedBox(width: size.width * .01),
                        Text(
                            addExpenses_page_controller.current_checkIn_response[0]
                                .lines![index].imageCount
                                .toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.lightblackColor,
                                fontSize: AllFontSize.sisxteen,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (index != addExpenses_page_controller.isExpend_line_posion.value) {
                addExpenses_page_controller.isExpend.value = true;
              } else {
                addExpenses_page_controller.isExpend.value =
                !addExpenses_page_controller.isExpend.value;
              }
              addExpenses_page_controller.isExpend_line_posion.value = index;
              addExpenses_page_controller.expense_current_index =index;
              print('my image_url is ::'+addExpenses_page_controller.current_checkIn_response[0].lines![index].imageUrl4!);

            },
          ),
          Obx(() {
            return Visibility(
              visible: (addExpenses_page_controller.isExpend.value &&
                  addExpenses_page_controller.isExpend_line_posion.value == index) ? true : false,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            // Adjust the height of the line as needed
                            color: Colors.black, // Change the color of the line
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Text(
                            "Files",
                            style: GoogleFonts.poppins(
                                fontSize: AllFontSize.sisxteen,
                                // Adjust the font size
                                fontWeight: FontWeight.w700,
                                color: AllColors
                                    .lightblackColor // Adjust the font weight
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            // Adjust the height of the line as needed
                            color: Colors.black, // Change the color of the line
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                addExpenses_page_controller.expense_current_index =
                                    index;
                                addExpenses_page_controller.getFrontImage(
                                    'Expense', 'image_one');
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  child: GetImageSection(
                                      index,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .local_image_path1,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .image_url),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .04),
                            GestureDetector(
                              onTap: () async {
                                addExpenses_page_controller.expense_current_index = index;
                                addExpenses_page_controller.getFrontImage(
                                    'Expense', 'image_two');
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  //child: GetImageSection(index,checkInpageController.file_path2.value,checkInpageController.image_url1.value),
                                  child: GetImageSection(
                                      index,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .local_image_path2,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .imageUrl2),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .04),
                            GestureDetector(
                              onTap: () async {
                                addExpenses_page_controller.expense_current_index =
                                    index;
                                addExpenses_page_controller.getFrontImage(
                                    'Expense', 'image_three');
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  //child: GetImageSection(index,checkInpageController.file_path3.value,checkInpageController.image_url2.value),
                                  child: GetImageSection(
                                      index,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .local_image_path3,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .imageUrl3),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .04),
                            GestureDetector(
                              onTap: () async {
                                addExpenses_page_controller.expense_current_index =
                                    index;
                                addExpenses_page_controller.getFrontImage(
                                    'Expense', 'image_four');
                              },
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                borderType: BorderType.RRect,
                                radius: Radius.circular(8),
                                dashPattern: [10, 5, 10, 5],
                                child: Container(
                                  width: size.height * 0.1,
                                  height: 70,
                                  //child: GetImageSection(index,checkInpageController.file_path4.value,checkInpageController.image_url3.value),
                                  child: GetImageSection(
                                      index,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .local_image_path4,
                                      addExpenses_page_controller
                                          .current_checkIn_response[0]
                                          .lines![index]
                                          .imageUrl4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: expenseController,
                            //initialValue: expenseController.toString(),
                            onChanged: (value) {
                              addExpenses_page_controller.place.value;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AllFontSize.two,
                                  horizontal: AllFontSize.one),
                              hintText: 'Amount',
                              hintStyle: GoogleFonts.poppins(
                                  color: AllColors.lightblackColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: AllFontSize.sisxteen),
                              labelStyle: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AllFontSize.sisxteen),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AllColors
                                        .primaryDark1), // Change the color to green
                              ),
                            ),
                            cursorColor: AllColors.primaryDark1,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                            child: DefaultButton(
                              text: "Save",
                              press: () {
                                addExpenses_page_controller.expense_line_save_DataApi(
                                    expenseController.text);
                              },
                              //loading: checkInpageController.loading.value,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }



  Widget GetImageSection(int index, String? path, String? imageUrl) {
    if (path != null && path.isNotEmpty) {
      print(path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.file(
          File(path.toString()),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.network(
          imageUrl.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else {
      return Icon(
        Icons.camera,
        size: 40,
        color: AllColors.primaryDark1,
      );
    }
  }


}