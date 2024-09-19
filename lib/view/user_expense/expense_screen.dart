import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/viewModel/user_expense_vm/user_expense_vm.dart';
import 'dart:io';
import '../../component/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/service_managment_model_directory/regionModel/region_model.dart';
import '../../models/user_expense_model/category_response.dart';
import '../custom_drawer.dart';

class ExpensesScreen extends StatelessWidget{
  ExpensesScreen({super.key});
  
  final expenseScreen_page_controller=Get.put(UserExpenseViewModel());
  static String _displaycategoryForOption(CatagoryResponse option) =>
      option.expenseName!;
  static String _displayRegionForOption(RegionModel option) =>
      option.regionName!;
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  async{
        Get.toNamed(RoutesName.myExpenseScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Expenses',
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
                Obx(() {
                  return Visibility(
                    visible: expenseScreen_page_controller.isPogressIndicator.value
                        ? true
                        : false,
                    child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.ripple_green,
                        minHeight: 5,
                        value: 0,
                      ),
                    ),
                  );
                }),


                SizedBox(height: size.height * .01,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Column(
                        children: [
                          Container(

                            child: Column(crossAxisAlignment: CrossAxisAlignment
                                .start,
                              children: [
                                Text(
                                    "Description (${expenseScreen_page_controller
                                        .expense_line_submit_list[0]
                                        .documentNo!})",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                                Text(
                                    expenseScreen_page_controller.expense_line_submit_list[0]
                                        .remarks!,
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w300,
                                    )
                                ),
                                SizedBox(height: 5,),
                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                Text(
                                    "Expenses Submitted",
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700,
                                    )
                                ),
                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                // Adding the ListView below the second divider
                                SizedBox(height: 5,),

                                Obx(() {
                                  final lines = expenseScreen_page_controller
                                      .expense_line_submit_list[0].lines;
                                  return Visibility(
                                    visible: expenseScreen_page_controller.isLinesVisible
                                        .value,
                                    child: lines != null && lines.length > 0
                                        ? Container(
                                      height: 200,
                                      child: ListView.separated(
                                        padding: EdgeInsets.all(1.0),
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              height: .05,
                                              color: AllColors.primaryDark1,
                                            ),
                                        shrinkWrap: true,
                                        itemCount: expenseScreen_page_controller
                                            .expense_line_submit_list[0].lines!
                                            .length,
                                        // Adjust the number of items as needed
                                        itemBuilder: (context, index) {
                                          return BindListView(context, index);
                                        },
                                      ),
                                    )
                                        : Center(
                                      child: Text("Data Not Found",
                                        style: GoogleFonts.poppins(
                                            color: AllColors.primaryDark1,
                                            fontWeight: FontWeight.w700,
                                            fontSize: AllFontSize.twentee
                                        ),
                                      ),
                                    ),
                                  );
                                }),

                                SizedBox(height: 5,),
                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                Obx(() {
                                  return Visibility(
                                    visible: expenseScreen_page_controller.isLinesVisible
                                        .value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                            "Total Amount",
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.sisxteen,
                                              fontWeight: FontWeight.w700,
                                            )
                                        ),
                                        Text(
                                            'Rs. ${expenseScreen_page_controller
                                                .expense_line_submit_list[0]
                                                .totalLineAmount.toString()}',
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w300,
                                            )
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                                Divider(color: AllColors.primaryDark1,
                                  height: 1,
                                  thickness: 1,),
                                SizedBox(height: size.height * .02),

                                Obx(() {
                                  return Visibility(
                                    visible: expenseScreen_page_controller.isCompleteBtn.value,
                                    // visible: expenseScreen_page_controller.expense_line_submit_list[0].status!='Pending'?expenseScreen_page_controller.isCompleteBtn.value:!expenseScreen_page_controller.isCompleteBtn.value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: DefaultButton(
                                            text: "Complete",
                                            press: () {
                                              expenseScreen_page_controller
                                                  .expenseCompleteApiHit();
                                            },
                                            //  loading: expenseScreen_page_controller.loading.value,
                                          ),
                                        ),
                                        SizedBox(width: size.width * .04),
                                        Expanded(
                                          child: DefaultButton(
                                            text: "Add New",
                                            press: () {
                                              expenseScreen_page_controller.isCompleteBtn
                                                  .value = false;
                                              expenseScreen_page_controller.isAddLinesVisible
                                                  .value = true;
                                              expenseScreen_page_controller.isLinesSubmit
                                                  .value = false;

                                              expenseScreen_page_controller.getExpenseCatagory(
                                                  'add_new');
                                            },
                                            // loading: expenseScreen_page_controller.loading.value,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Obx(() {
                            return Visibility(
                              visible: expenseScreen_page_controller.isAddLinesVisible.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bindCatagoryDropDown(context),
                                  SizedBox(height: 8),
                                  TextFormField(
                                    enabled: expenseScreen_page_controller
                                        .expense_line_submit_list[0].status ==
                                        'Pending' ? true : false,
                                    controller: expenseScreen_page_controller
                                        .amount_controller,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    onChanged: (value) {
                                      expenseScreen_page_controller.amount_controller.value;
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
                                        borderSide: BorderSide(color: AllColors
                                            .primaryDark1), // Change the color to green
                                      ),
                                    ),
                                    cursorColor: AllColors.primaryDark1,
                                  ),
                                  Obx(() {
                                    return Visibility(
                                      visible: expenseScreen_page_controller.isLodging > 0
                                          ? true
                                          : false,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                //SizedBox(height: 8),
                                                Container(
                                                    width: size.width * .3,
                                                    child: bindDatePickerFrom(
                                                        context)),
                                                Container(
                                                    width: size.width * .3,
                                                    child: bindDatePickerTO(
                                                        context)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8.0,),
                                          bindRegionNameDropDown(context),
                                        ],

                                      ),
                                    );
                                  }),
                                  Obx(() {
                                    return Visibility(
                                      visible: expenseScreen_page_controller.isKm > 0
                                          ? true
                                          : false,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 8),
                                          bindTotalKm(context),
                                        ],
                                      ),
                                    );
                                  }),
                                  SizedBox(height: 8),
                                  bindRemarks(context),
                                  SizedBox(height: size.height * .05),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      //todo obx comment when reset button click ui Damage then obx comment....
                                      /* Obx(() {
                                          return*/
                                      Expanded(
                                        child: Visibility(
                                          visible: expenseScreen_page_controller
                                              .expense_line_submit_list[0]
                                              .status!.toLowerCase() ==
                                              'pending',
                                          child: DefaultButton(
                                            text: "Submit Line",
                                            press: () {
                                              expenseScreen_page_controller
                                                  .hitExpenseLineSubmit(
                                                  expenseScreen_page_controller.document_no
                                                      .toString(), 'expense',
                                                  null);
                                            },

                                            //  loading: expenseScreen_page_controller.loading.value,
                                          ),
                                        ),
                                      ),
                                      // }),
                                      SizedBox(width: size.width * .01),
                                      Expanded(
                                        child: DefaultButton(
                                          text: "Back",
                                          press: () {
                                            expenseScreen_page_controller
                                                .description_controller.clear();
                                            expenseScreen_page_controller.date_controller
                                                .clear();
                                            expenseScreen_page_controller
                                                .expense_catagory_controller
                                                .clear();
                                            expenseScreen_page_controller.amount_controller
                                                .clear();

                                            expenseScreen_page_controller.file_path0.value =
                                            '';
                                            expenseScreen_page_controller.file_path1.value =
                                            '';
                                            expenseScreen_page_controller.file_path2.value =
                                            '';
                                            expenseScreen_page_controller.file_path3.value =
                                            '';

                                            expenseScreen_page_controller.image_url.value = '';
                                            expenseScreen_page_controller.image_url1.value =
                                            '';
                                            expenseScreen_page_controller.image_url2.value =
                                            '';
                                            expenseScreen_page_controller.file_path3.value =
                                            '';
                                            if (expenseScreen_page_controller
                                                .expense_line_submit_list[0]
                                                .status == 'Pending') {
                                              expenseScreen_page_controller.isCompleteBtn
                                                  .value = true;
                                              expenseScreen_page_controller.isAddLinesVisible
                                                  .value = false;
                                              expenseScreen_page_controller.isLinesSubmit
                                                  .value = true;
                                            }
                                            expenseScreen_page_controller.isAddLinesVisible
                                                .value = false;
                                          },
                                          // loading: expenseScreen_page_controller.loading.value,
                                        ),
                                      ),
                                      SizedBox(width: size.width * .01),
                                      GestureDetector(
                                          onTap: () async {
                                            FocusScopeNode currentFocus = FocusScope
                                                .of(context);
                                            if (!currentFocus.hasPrimaryFocus &&
                                                currentFocus.focusedChild !=
                                                    null) {
                                              currentFocus.focusedChild
                                                  ?.unfocus();
                                            }
                                            //expenseScreen_page_controller.getFile();
                                            if (expenseScreen_page_controller.isShowImage
                                                .value == true)
                                              expenseScreen_page_controller.isShowImage.value =
                                              false;
                                            else
                                              expenseScreen_page_controller.isShowImage.value =
                                              true;
                                          },
                                          child: Icon(Icons.attach_file,
                                            color: AllColors.lightblackColor,)),
                                      // Replace with your desired attachment icon
                                      SizedBox(width: size.width * .01),
                                      // Add spacing between the icon and text
                                      Text(expenseScreen_page_controller.files_count > 0
                                          ? expenseScreen_page_controller.files_count
                                          .toString()
                                          : '0', style: GoogleFonts.poppins(
                                          color: AllColors.lightblackColor,
                                          fontSize: AllFontSize.sisxteen,
                                          fontWeight: FontWeight.w700
                                      ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02,),
                                  Obx(() {
                                    return Visibility(
                                      visible: expenseScreen_page_controller.isShowImage.value,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 1,
                                                // Adjust the height of the line as needed
                                                color: Colors
                                                    .black, // Change the color of the line
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 4.0),
                                              child: Text(
                                                "Files",
                                                style: GoogleFonts.poppins(
                                                    fontSize: AllFontSize
                                                        .sisxteen,
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
                                                color: Colors
                                                    .black, // Change the color of the line
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.02,),
                                        Obx(() {
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Visibility(
                                              visible: expenseScreen_page_controller
                                                  .isShowImage.value,

                                              child: Center(
                                                  child: Row(
                                                    children: [
                                                      linefileBindUi('file_one',
                                                          expenseScreen_page_controller
                                                              .image_url.value,
                                                          expenseScreen_page_controller
                                                              .file_path0
                                                              .value),
                                                      SizedBox(
                                                          width: size.width *
                                                              .02),
                                                      linefileBindUi('file_two',
                                                          expenseScreen_page_controller
                                                              .image_url1.value,
                                                          expenseScreen_page_controller
                                                              .file_path1
                                                              .value),
                                                      SizedBox(
                                                          width: size.width *
                                                              .02),
                                                      linefileBindUi(
                                                          'file_three',
                                                          expenseScreen_page_controller
                                                              .image_url2.value,
                                                          expenseScreen_page_controller
                                                              .file_path2
                                                              .value),
                                                      SizedBox(
                                                          width: size.width *
                                                              .02),
                                                      linefileBindUi(
                                                          'file_four',
                                                          expenseScreen_page_controller
                                                              .image_url3.value,
                                                          expenseScreen_page_controller
                                                              .file_path3
                                                              .value),
                                                    ],
                                                  )
                                              ),
                                            ),
                                          );
                                        }),
                                        SizedBox(height: size.height * 0.02,),
                                        Visibility(
                                          visible: expenseScreen_page_controller
                                              .expense_line_submit_list[0]
                                              .status == 'Pending' && expenseScreen_page_controller
                                              .expense_line_submit_list[0].lines![0].imageCount!<4
                                              ? expenseScreen_page_controller.addFileButton
                                              .value
                                              : false,
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
                                              showCinfirmationDialog(
                                                  context);
                                              //await expenseScreen_page_controller.getFile('');
                                            },
                                          ),
                                        )
                                      ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: size.height * .02,)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  //todo listview bind
  Widget BindListView(context, int position) {
    final line = expenseScreen_page_controller.expense_line_submit_list[0].lines![position];
    return InkWell(
      child: ListTile(
        onTap: () {
          expenseScreen_page_controller.selectedContainerIndex.value = line.imageCount!;
          expenseScreen_page_controller.resetAllfieldsAndPath();
          expenseScreen_page_controller.showExpenseLineDetails(position);
        },
        title: Row(
          children: [
            Text(line.expenseName ?? '',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500,
                  fontSize: AllFontSize.fourtine,
                )),
            Icon(
              Icons.attach_file, color: AllColors.lightblackColor, size: 18,),
            SizedBox(width: size.width * .01),
            // Add spacing between the icon and text
            Text(line.imageCount!.toString() ?? ''
              , style: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
        subtitle: Text(line.expenseRemark ?? '',
            style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.fourtine,
            )),
        // leading: Text('Rs. 12000.00'),
        trailing: Text('RS. ${line.expenseAmount.toString()}',
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.fourtine,
          ),),
      ),
    );
  }

  Widget bindCatagoryDropDown(context) {
    return Autocomplete<CatagoryResponse>(
      displayStringForOption: _displaycategoryForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return expenseScreen_page_controller.expense_catagory_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return expenseScreen_page_controller.expense_catagory_list
            .where((CatagoryResponse option) {
          return option.expenseName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CatagoryResponse selection) {
        print(selection.expenseName);
        expenseScreen_page_controller.isLodging.value = selection.isLodging!;
        expenseScreen_page_controller.isKm.value = selection.isKm!;
        expenseScreen_page_controller.expense_catagory_controller.text =
            _displaycategoryForOption(selection).toString();
        expenseScreen_page_controller.image_requred.value = selection.imageRequired!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          enabled: expenseScreen_page_controller.expense_line_submit_list[0].status ==
              'Pending' ? true : false,
          controller: controller
            ..text = expenseScreen_page_controller.expense_catagory_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
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

  Widget bindDatePickerFrom(context) {
    return TextFormField(
      enabled: expenseScreen_page_controller.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: expenseScreen_page_controller.from_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
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
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },

        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          expenseScreen_page_controller.from_date_controller.text =
              outputFormat.format(date);
        else
          expenseScreen_page_controller.from_date_controller.text = "";
      },
    );
  }

  Widget bindDatePickerTO(context) {
    return TextFormField(
      enabled: expenseScreen_page_controller.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: expenseScreen_page_controller.to_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "To Date",
        labelText: 'To Date',
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
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
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
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          expenseScreen_page_controller.to_date_controller.text =
              outputFormat.format(date);
        else
          expenseScreen_page_controller.to_date_controller.text = "";
      },
    );
  }

  Widget bindTotalKm(context) {
    return TextFormField(
      enabled: expenseScreen_page_controller.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: expenseScreen_page_controller.total_km_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        expenseScreen_page_controller.total_km_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Total Km",
        labelText: "Total Km",

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
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

  Widget bindRemarks(context) {
    return TextFormField(
      enabled: expenseScreen_page_controller.expense_line_submit_list[0].status == 'Pending'
          ? true
          : false,
      controller: expenseScreen_page_controller.remark_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        expenseScreen_page_controller.remark_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Remarks",
        labelText: "Remarks",

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
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

  Widget bindRegionNameDropDown(context) {
    return Autocomplete<RegionModel>(
      displayStringForOption: _displayRegionForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return expenseScreen_page_controller.region_name_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        if(expenseScreen_page_controller.region_name_list.isEmpty)
        {
          expenseScreen_page_controller.region_name_list=[];
        }
        return expenseScreen_page_controller.region_name_list
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
        expenseScreen_page_controller.region_catagory_controller.text =
            _displayRegionForOption(selection).toString();
        expenseScreen_page_controller.region_name.value = selection.regionName!;
        expenseScreen_page_controller.region_code.value = selection.regionCode!;
        print(expenseScreen_page_controller.region_code.value);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          enabled: expenseScreen_page_controller.expense_line_submit_list[0].status ==
              'Pending' ? true : false,
          controller: controller
            ..text = expenseScreen_page_controller.region_catagory_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
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
                      child: Text(
                        option.regionName.toString(),
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


  Widget linefileBindUi(String flag, String image_url, String file_path) {
    if (expenseScreen_page_controller.isShowImage.value) {
      print(flag + '   ' + image_url + '  ' + file_path);
      if (file_path.isNotEmpty && (file_path.toLowerCase().endsWith('.png')
          || file_path.toLowerCase().endsWith('.jpeg')
          || file_path.toLowerCase().endsWith('.jpg'))) {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.file(
                    File(file_path.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment code...(15-01-2024)
            /* if(expenseScreen_page_controller.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              if(file_path.isNotEmpty || image_url.isNotEmpty)
                await expenseScreen_page_controller.getFile(flag);
              else
                Utils.sanckBarError('Image', 'Please Click Add Button!');
            }
*/
          },
        );
      }
      else
      if (file_path.isNotEmpty && file_path.toLowerCase().endsWith('.pdf')) {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.picture_as_pdf,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)
            /* if(expenseScreen_page_controller.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await expenseScreen_page_controller.getFile(flag);
            }*/

          },
        );
      }
      else if (file_path.isNotEmpty &&
          (file_path.toLowerCase().endsWith('.doc') ||
              file_path.toLowerCase().endsWith('.docx'))) {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.file_copy,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            if (expenseScreen_page_controller.expense_line_submit_list[0].status!
                .toLowerCase() == 'pending') {
              await expenseScreen_page_controller.getFile(flag);
            }
          },
        );
      }
      else if (file_path.isEmpty && image_url.isNotEmpty &&
          (image_url.toLowerCase().endsWith('.png')
              || image_url.toLowerCase().endsWith('.jpeg')
              || image_url.toLowerCase().endsWith('.jpg'))
      ) {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    image_url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*if(expenseScreen_page_controller.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await expenseScreen_page_controller.getFile(flag);
            }
*/
          },
        );
      }
      else if (file_path.isEmpty && image_url.isNotEmpty &&
          image_url.toString().endsWith('.pdf')) {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.picture_as_pdf,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*if(expenseScreen_page_controller.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await expenseScreen_page_controller.getFile(flag);
            }*/

          },
        );
      }
      else if (file_path.isEmpty && image_url.isNotEmpty &&
          (image_url.toString().endsWith('.doc') ||
              image_url.toString().endsWith('.docx'))) {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.file_copy,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*if(expenseScreen_page_controller.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await expenseScreen_page_controller.getFile(flag);
            }*/

          },
        );
      }
      else {
        return GestureDetector(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Icon(
                    Icons.image,
                    size: 60,
                    color: AllColors.primaryDark1,
                  ),
                ),
              ),
            ),
          ),
          onTap: () async {
            //todo comment  code when we click image box Code comment....(15-01-2024)

            /*     if(expenseScreen_page_controller.expense_line_submit_list[0].status!.toLowerCase()=='pending'){
              await expenseScreen_page_controller.getFile(flag);
            }*/

          },
        );
      }
    }
    else {
      return Text('No Record Found', style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.fourtine,
          fontWeight: FontWeight.w500
      ),);
    }
  }

  void showCinfirmationDialog(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Choose Option.....",
            style: TextStyle(color: AllColors.primaryDark1,)),
        content: Container(
          //height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(height: .5, color: AllColors.lightgreyColor,),
              GestureDetector(
                onTap: () async {
                  await expenseScreen_page_controller.getFile('');
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
                  expenseScreen_page_controller.upLoadImage(context, '');
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
}