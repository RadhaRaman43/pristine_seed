import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../component/default_button.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TourPlanAccount_Model.dart';
import '../../CRM_Models/Bussiness_Tour_Plan_Model/TouringDistrictModel.dart';
import '../../CRM_Models/sale_cycle_modal/alongWithPersonModel.dart';
import '../../CRM_VIewModels/Bussiness_Tour_Plan_Vm/BusinessPlanTour_Vm.dart';
import '../../CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../../CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';

class AddTourLinesPage extends StatelessWidget{
  AddTourLinesPage({super.key});

  BusinessPlanTourViewModel businessTourPlanController = Get.put(BusinessPlanTourViewModel());
  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_page_controller=Get.put(ContactMasterVM());
  Size size = Get.size;

  static String _displayAlongPersonForOption(AlongWithPersonModel option) =>
      (option.firstName?.toString() ?? "") +
          " " +
          (option.middleName?.toString() ?? "") +
          " " +
          (option.lastName?.toString() ?? "");

  static String _displayTourPlanDistrictForOption(TouringDistrictModel option) =>
      option.district!;

  static String _displayTourTypeForOption(TouringDistrictModel option) =>
      option.type!;

  static String _displayTourPlanAccountForOption(TourPlanAccountModel option) =>
      "${option.accountName!}(${option.accountCode.toString()})";

  static String _displayMeetingWithForOption(TourPlanAccountModel option) =>
      option.contactName!;

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: () async {
       businessTourPlanController.customerVisible.value =true;
       Get.toNamed(RoutesName.BusinessTourPlanDetails);
       return false;
     },
       child: Scaffold(
         appBar: AppBar(
             backgroundColor: AllColors.primaryDark1,
             iconTheme: IconThemeData(
               color: AllColors.whiteColor,
             ),
             title: Text(
               'Create Tour Line',
               style: GoogleFonts.poppins(
                 color: AllColors.whiteColor,
                 fontSize: 17.0,
                 fontWeight: FontWeight.w700,
               ),
             )),
         drawer: CustomDrawer(),
         floatingActionButton:  Container(
           margin: EdgeInsets.only(left: 30),
           child: DefaultButton(
             press: (){
               if(businessTourPlanController.TourPlanDistrict_Controller.text.isEmpty){
                 Utils.sanckBarError('Touring District!', "Please Select Touring District");
                 return  ;
               }

               if(businessTourPlanController.tourDate_Controller.text.isEmpty){
                 Utils.sanckBarError('Tour Date!', "Please Select Tour Data");
                 return  ;
               }
               if(businessTourPlanController.TourType_Controller.value.text.isEmpty){
                 Utils.sanckBarError('Tour Type!', "Please Select tour Type");
                 return  ;
               }
               if(businessTourPlanController.TourPlanAccount_Controller.value.text.isEmpty){
                 Utils.sanckBarError('Customer!', "Please Select Customer");
                 return  ;
               }
               if(businessTourPlanController.MeetingWith_controller.value.text.isEmpty){
                 Utils.sanckBarError('Meeting With!', "Please Select Meeting With");
                 return  ;
               }

               if(businessTourPlanController.TourPlanObjective_Controller.value.text.isEmpty){
                 Utils.sanckBarError('Objective!', "Please Enter Objective");
                 return  ;
               }

               if(businessTourPlanController.TourPlanRemarks_Controller.value.text.isEmpty){
                 Utils.sanckBarError('Remarks!', "Please Enter Remarks");
                 return  ;
               }

               ConfirmationDialog(context, businessTourPlanController.Tour_Id);

               //accountMaster_page_controller.AccountMstUploaderApiHit('Create', "", accountMaster_page_controller.SalesRepresentativeEmail, accountMaster_page_controller.RegionalHeadEmail);
             },
             text: "Create Tour Line",
           ),
         ),
         body: Container(
           padding: EdgeInsets.only(bottom: 70),
           width: double.infinity,
           height: double.infinity,
           child: SingleChildScrollView(
             child: Column(
               children: [
                 SizedBox(height: 10),
                 Column(
                   children: [
                     const SizedBox(height: 15,),
                     bindTouringDistrictDropDown(context),
                     const SizedBox(height: 15,),
                     BindTourDate(context),
                     const SizedBox(height: 10,),
                     Obx((){
                       return Visibility(
                         visible: businessTourPlanController.tourType.value,
                           child:  BindTourTypeDropDown(context));
                     }),

                     const SizedBox(height: 10,),
                     bindAccompaniedWithDropDown(context),
                     const SizedBox(height: 10,),
                     Obx(() {
                       return
                         Wrap(
                           spacing: 8.0,
                           children: businessTourPlanController.SelectedAlongPersonWith_list.map((category) {
                             return Chip(
                               label: Text((category.firstName?.toString() ?? "") +
                                   " " +
                                   (category.middleName?.toString() ?? "") +
                                   " " +
                                   (category.lastName?.toString() ?? "")
                               ),
                               onDeleted: () {
                                 businessTourPlanController.SelectedAlongPersonWith_list.remove(category);
                               },
                             );
                           }).toList(),
                         );

                     }),
                     const SizedBox(height: 10,),
                     Obx((){
                       return Visibility(
                         visible: businessTourPlanController.customerVisible.value ,
                         child: Container(
                           padding: EdgeInsets.only( right: 15.0),
                           height: 50,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Expanded(
                                 child: Container(
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child: bindTourPlanAccountDropDown(context),
                                 ),
                               ),
                               Container(
                                 margin: EdgeInsets.only(left: 10),
                                 decoration: BoxDecoration(
                                   color: AllColors.whiteColor,
                                   borderRadius: BorderRadius.circular(10),
                                   border: Border.all(
                                     color: AllColors.lightblackColor, // Set the border color to black
                                     width: 1.0, // You can adjust the width of the border as needed
                                   ),
                                 ),
                                 child: IconButton(
                                     onPressed: (){
                                       accountMaster_page_controller.FromPage.value = 'AddTourLine';
                                       accountMaster_page_controller.DraftId = '';
                                       accountMaster_page_controller.clearController();
                                       accountMaster_page_controller.getEmployeeMemberApi();
                                       accountMaster_page_controller.getCompanyProfileTypeApi("");
                                       accountMaster_page_controller.getCompanyProfileSubTypeApi();
                                       accountMaster_page_controller.getGeoPostalCodeApi(50,'',accountMaster_page_controller.email);
                                       Get.toNamed(RoutesName.add_New_AccountMaster_screen);
                                     }, icon: Icon(Icons.add)),
                               ),

                             ],
                           ),
                         ),
                       );
                     }),

                     const SizedBox(height: 10,),
                     Obx((){
                       //print("client meeting with ${businessTourPlanController.TourType_Controller.value.text.toString().trim().toLowerCase()}");
                       return Visibility(
                           visible: businessTourPlanController.meetingWith.value && businessTourPlanController.tourType.value?true:false ,
                           child:businessTourPlanController.TourType_Controller.value.text.toString().trim().toLowerCase()=="client meeting"? creatEAccountAndMeetingWithDropDown(context)/*bindMeetingWithDropDown(context)*/:MeetingWithTextField(context));
                     }),
                     const SizedBox(height: 10,),
                     Obx(() {
                       return
                         Wrap(
                           spacing: 8.0,
                           children: businessTourPlanController.SelectedMeetingWith_List.map((category) {
                             return Chip(
                               label: Text((category.contactName?.toString() ?? "")),
                               onDeleted: () {
                                 businessTourPlanController.SelectedMeetingWith_List.remove(category);
                               },
                             );
                           }).toList(),
                         );

                     }),
                     const SizedBox(height: 10,),
                     BindObjectiveTextField(context),
                     const SizedBox(height: 10,),
                     BindRemarksTextField(context),
                     const SizedBox(height: 10,),

                   ],
                 ),

               ],
             ),
           ),
         ),
       ),
   );
  }

  Widget BindTourDate(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          controller: businessTourPlanController.tourDate_Controller,
          readOnly: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.ten),
              suffixIcon: Icon(Icons.calendar_month),
              hintText: 'Tour Date*',
              labelText: 'Tour Date*',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          cursorColor: AllColors.primaryDark1,
          onTap: () async {

            DateTime stating_date = DateTime(1900);
            DateTime ending_date = DateTime(2200);

            if (businessTourPlanController.StartDate.isNotEmpty) {
              stating_date = DateFormat('yyyy-MM-dd').parse(businessTourPlanController.StartDate);
            }
            if (businessTourPlanController.EndDate.isNotEmpty) {
              ending_date = DateFormat('yyyy-MM-dd').parse(businessTourPlanController.EndDate);
            }
            // Check if a date is already selected and parse it
            DateTime initialDate = DateTime.now();
            if (businessTourPlanController.startDateController.value.text.isNotEmpty) {
              initialDate = DateFormat('yyyy-MM-dd').parse(
                businessTourPlanController.startDateController.value.text,
              );
            }

            if (initialDate.isBefore(stating_date)) {
              initialDate = stating_date;
            } else if (initialDate.isAfter(ending_date)) {
              initialDate = ending_date;
            }


            // Remove focus from the field
            FocusScope.of(context).requestFocus(FocusNode());

            // Show the date picker
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate.isBefore(stating_date) ? stating_date : initialDate,
              firstDate: stating_date,
              lastDate: ending_date,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: AllColors.primaryDark1,
                    colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );

            // Update the controller with the selected date
            if (date != null) {
              var outputFormat = DateFormat('yyyy-MM-dd');
              businessTourPlanController.tourDate_Controller.text =
                  outputFormat.format(date);
            }
          },
        ),
      ),
    );
  }

  Widget BindTourTypeDropDown(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        // margin: const EdgeInsets.only(left: 15.0),
        width: double.infinity,
        child: DropdownMenu<TouringDistrictModel>(
          width: size.width-30,
          controller:  businessTourPlanController.TourType_Controller.value,
          label: Text(
            "Tour Type",
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen,
                fontWeight: FontWeight.w300),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AllColors.primaryDark1,),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),

            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
            filled: false,
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
          ),
          onSelected: (TouringDistrictModel? selection) {
            print(selection);
            businessTourPlanController.tourType.value=false;
            businessTourPlanController.tourType.value=true;
            businessTourPlanController.TourType_Controller.value.clear();
            businessTourPlanController.MeetingWith_controller.value.clear();
            businessTourPlanController.SelectedMeetingWith_List.value=[];
            businessTourPlanController.TourType_Controller.value.text = _displayTourTypeForOption(selection!).toString();
            if(businessTourPlanController.TourType_Controller.value.text.toLowerCase() !="administrative"){
              businessTourPlanController.customerVisible.value =true;
            }
            else{
              businessTourPlanController.customerVisible.value =false;
            }
            businessTourPlanController.selectMeetingWith.value=true;

          },

          dropdownMenuEntries: businessTourPlanController.TourType_List.map<DropdownMenuEntry<TouringDistrictModel>>((TouringDistrictModel e) {
            return DropdownMenuEntry<TouringDistrictModel>(value: e, label: e.type!,style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
          }).toList(),
        ),
      ),
    );
  }

  Widget BindObjectiveTextField(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        //padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextFormField(
          controller: businessTourPlanController
              .TourPlanObjective_Controller,
          decoration: InputDecoration(
              hintText: "Objective*",
              labelText: "Objective*",
              //suffixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten,
                  horizontal: AllFontSize.ten),

              /* focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.blue)
                               ),*/
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),

        ),
      ),
    );
  }

  Widget MeetingWithTextField(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        //padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextFormField(
          controller: businessTourPlanController
              .MeetingWith_controller.value,
          decoration: InputDecoration(
              hintText: "Meeting With*",
              labelText: "Meeting With*",
              //suffixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten,
                  horizontal: AllFontSize.ten),

              /* focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.blue)
                               ),*/
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),

        ),
      ),
    );
  }

  Widget BindRemarksTextField(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        //padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextFormField(
          maxLength: 500,
          maxLines: 3,
          controller: businessTourPlanController
              .TourPlanRemarks_Controller,
          decoration: InputDecoration(
              hintText: "Remarks*",
              labelText: "Remarks*",
              //suffixIcon: Icon(Icons.email),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten,
                  horizontal: AllFontSize.ten),

              /* focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.blue)
                               ),*/
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),

        ),
      ),
    );
  }

  Widget bindTouringDistrictDropDown(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Autocomplete<TouringDistrictModel>(
        displayStringForOption: _displayTourPlanDistrictForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            return businessTourPlanController.TouringDistirct_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return await businessTourPlanController.getTourPlanDistrictTypeApi(textEditingValue.text);
        },
        onSelected: (TouringDistrictModel selection) {
          //print(selection.loginEmailId);
          // Update the TextField with the selected
          businessTourPlanController.TourPlanDistrict_Controller.text =
              _displayTourPlanDistrictForOption(selection).toString();

        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: (){
              if(focusNode.hasFocus){
                focusNode.unfocus();
              }else{
                focusNode.requestFocus();
              }
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = businessTourPlanController.TourPlanDistrict_Controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Touring District*',
              labelText: 'Touring District*',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<TouringDistrictModel> onSelected,
            Iterable<TouringDistrictModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.9,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final TouringDistrictModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.district.toString(),
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
      ),
    );
  }

  Widget bindTourPlanAccountDropDown(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Autocomplete<TourPlanAccountModel>(
        displayStringForOption: _displayTourPlanAccountForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            businessTourPlanController.TourPlanContact_List.value= [];
            return businessTourPlanController.TourPlanAccount_List;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return await businessTourPlanController.getTourPlanAccountTypeApi(textEditingValue.text);
        },
        onSelected: (TourPlanAccountModel selection) {
          businessTourPlanController.TourPlanAccount_Controller.value.text =
              _displayTourPlanAccountForOption(selection).toString();
          businessTourPlanController.meetingWith.value = false;
          businessTourPlanController.meetingWith.value = true;
          businessTourPlanController.CustomerId  = selection.accountCode??"";
          businessTourPlanController.BusinessTourPlanContactGet(selection.accountCode??"");

        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: (){
              if(focusNode.hasFocus){
                focusNode.unfocus();
              }else{
                focusNode.requestFocus();
              }
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = businessTourPlanController.TourPlanAccount_Controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Customer*',
              labelText: 'Customer*',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<TourPlanAccountModel> onSelected,
            Iterable<TourPlanAccountModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: size.width*.9,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final TourPlanAccountModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text("${option.accountName.toString()}(${option.accountCode.toString()})",
                          style: GoogleFonts.poppins(
                              color: AllColors.blackColor,
                              fontWeight: FontWeight.w300,
                              fontSize: AllFontSize.sisxteen // Change the text color here
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
      ),
    );
  }

  Widget creatEAccountAndMeetingWithDropDown(context){
    return Container(
      padding: EdgeInsets.only( right: 15.0),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: bindMeetingWithDropDown(context),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: AllColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AllColors.lightblackColor, // Set the border color to black
                width: 1.0, // You can adjust the width of the border as needed
              ),
            ),
            child: IgnorePointer(
              ignoring: businessTourPlanController.TourPlanAccount_Controller.value.text == ""? true:false,
              child: IconButton(
                  onPressed: (){
                    contact_vm_page_controller.FromPage.value="AddTourLine";
                    contact_vm_page_controller.resetAllContactCreativeField("Icon");
                    Get.toNamed(RoutesName.addNewContactMaster_screen);
                  }, icon: Icon(Icons.add)),
            ),
          ),

        ],
      ),
    );
  }

  Widget bindMeetingWithDropDown(context){
      return IgnorePointer(
        ignoring: businessTourPlanController.TourPlanAccount_Controller.value.text == ""? true:false,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Autocomplete<TourPlanAccountModel>(
            displayStringForOption: _displayMeetingWithForOption,
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return businessTourPlanController.TourPlanContact_List;
                // return const Iterable<VehicleTypeResponse>.empty();
              }
              return businessTourPlanController.TourPlanContact_List
                  .where((TourPlanAccountModel option) {
                return option.contactName
                    .toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              }).toList();
            },
            onSelected: (TourPlanAccountModel selection) {
              print(selection.contactName);
              // Update the TextField with the selected
              businessTourPlanController.MeetingWith_controller.value.text =
                  _displayMeetingWithForOption(selection).toString();

              if (!businessTourPlanController.SelectedMeetingWith_List.contains(selection)) {
                businessTourPlanController.SelectedMeetingWith_List.add(selection);
                businessTourPlanController.SelectedMeetingWith_List1.add(selection.contactName??"");

                Utils.showToastification('Success', 'Add Successfully');
              }else{
                Utils.showErrorToastification('Error', 'Already Selected');
              }
            },
            fieldViewBuilder: (BuildContext context, TextEditingController controller,
                FocusNode focusNode, VoidCallback onFieldSubmitted) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  cursorColor: AllColors.primaryDark1,
                  controller: controller
                    ..text = businessTourPlanController.MeetingWith_controller.value
                        .text,
                  focusNode: focusNode,
                  //onSubmitted: onFieldSubmitted,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: AllColors.primaryDark1,
                      onPressed: (){
                        if(focusNode.hasFocus){
                          focusNode.unfocus();
                        }else{
                          focusNode.requestFocus();
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
                    hintText: 'Meeting With*',
                    labelText: 'Meeting With*',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
              );
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<TourPlanAccountModel> onSelected,
                Iterable<TourPlanAccountModel> suggestions) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  elevation: 4.0,
                  child: Container(
                    width: size.width*.85,
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final TourPlanAccountModel option =
                        suggestions.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:  option.contactName??"",
                                      style: GoogleFonts.poppins(
                                          color: AllColors.blackColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: AllFontSize
                                              .sisxteen // Change the text color here
                                      ),
                                    ),
                                    /*TextSpan(
                                    text: " (${option.contactName!})",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.redColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: AllFontSize
                                            .sisxteen // Change the text color here
                                    ),
                                  ),*/
                                  ],
                                ),
                                softWrap: true,
                              )
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

  }


  Widget bindAccompaniedWithDropDown(context){
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Autocomplete<AlongWithPersonModel>(
        displayStringForOption: _displayAlongPersonForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return businessTourPlanController.AlongPersonWith_list;
            // return const Iterable<VehicleTypeResponse>.empty();
          }
          return businessTourPlanController.AlongPersonWith_list
              .where((AlongWithPersonModel option) {
            return option.firstName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (AlongWithPersonModel selection) {
          // Update the TextField with the selected
          businessTourPlanController.AlongPersonWith_controller.text =
              _displayAlongPersonForOption(selection).toString();

          if (!businessTourPlanController.SelectedAlongPersonWith_list.contains(selection)) {
            businessTourPlanController.SelectedAlongPersonWith_list.add(selection);
            businessTourPlanController.SelectedAlongPersonWith_list1.add((selection.firstName ?? "") +
                " " +
                (selection.middleName?? "") +
                " " +
                (selection.lastName?? ""),);
            Utils.showToastification('Success', 'Add Successfully');
          }else{
            Utils.showErrorToastification('Error', 'Already Selected');
          }

          // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            onTap: (){
              businessTourPlanController.AlongPersonWith_controller.clear();
              if(focusNode.hasFocus){
                focusNode.unfocus();
              }else{
                focusNode.requestFocus();
              }
            },
            cursorColor: AllColors.primaryDark1,
            controller: controller
              ..text = businessTourPlanController.AlongPersonWith_controller
                  .text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                color: AllColors.primaryDark1,
                onPressed: (){
                  businessTourPlanController.AlongPersonWith_controller.clear();
                  if(focusNode.hasFocus){
                    focusNode.unfocus();
                  }else{
                    focusNode.requestFocus();
                  }
                },
                icon: Icon(Icons.arrow_drop_down),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.ten, horizontal: AllFontSize.ten),
              hintText: 'Accompanied With',
              labelText: 'Accompanied With',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<AlongWithPersonModel> onSelected,
            Iterable<AlongWithPersonModel> suggestions) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              elevation: 4.0,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final AlongWithPersonModel option =
                    suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:  (option.firstName?.toString() ?? "") +
                                    " " +
                                    (option.middleName?.toString() ?? "") +
                                    " " +
                                    (option.lastName?.toString() ?? ""),
                                style: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                ),
                              ),
                              TextSpan(
                                text: " (${option.empId!})",
                                style: GoogleFonts.poppins(
                                    color: AllColors.redColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: AllFontSize
                                        .sisxteen // Change the text color here
                                ),
                              ),
                            ],
                          ),
                          softWrap: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  ConfirmationDialog(context, String TourId){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: AllColors.textColor,),
                SizedBox(width: 5,),
                Text(
                    'Create Line !',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ))
              ],
            ),
            content: Wrap(
                children: [
                  Column(
                    children: [
                      Text(
                          'Do You Want To Create Line ?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.lightredColor,
                              ),
                            ),
                            onPressed: ()  {
                              Get.back();

                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Cancel',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AllColors.greenblue,
                              ),
                            ),
                            onPressed: ()  {
                              businessTourPlanController.BusinessTourPlanLinesCreate(TourId);
                              Get.back();
                              //Navigator.pop(context);
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Submit',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),]
            ),
          );

        });
  }


}