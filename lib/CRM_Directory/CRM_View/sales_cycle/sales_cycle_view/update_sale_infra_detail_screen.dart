import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../component/default_button.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_font_size.dart';
import '../../../../utils/app_utils.dart';
import '../../../../view/custom_drawer.dart';
import '../../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../../CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';

class UpdateSaleInfraDetailScreen extends StatelessWidget{

  UpdateSaleInfraDetailScreen({super.key});
  final saleCycleController = Get.put(SalesCycleVm());
  Size size=Get.size;
  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
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
                'Update Task Infra',
                style: GoogleFonts.poppins(
                  color: AllColors.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              /* ActionChip(
                  elevation: 2,
                  padding: EdgeInsets.all(5),
                  backgroundColor: AllColors.primaryDark1,
                  shadowColor: Colors.black,
                  shape: StadiumBorder(
                      side: BorderSide(color: AllColors.whiteColor)),
                  //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                  //CircleAvatar
                  label: Tooltip(
                    message: "Create DSAR ",
                    child: Text('Submit',
                        style: GoogleFonts.poppins(
                          color: AllColors.whiteColor,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  onPressed: () {
                    saleCycleController.gettaskMstInfraUpdate();
                  }, //Text
                ),*/


            ],
          )
      ),
      drawer: CustomDrawer(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left:30),
        child: DefaultButton(
          text: "Submit",
          press: (){
              saleCycleController.SalesCycleMstInfraUpdate(saleCycleController.saleCycleList[0].infraLeadNo??"");

          },
        ),

      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 70),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AllColors.grayColor, // Set the border color here
                      width: 1.0, // Adjust the border width if necessary
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'New Infrastructure Lead',
                      labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(

                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        bindIsInfraLead(context),
                        const SizedBox(height: 10,),
                        bindInputData(context,"User Region", saleCycleController.userRegionUpdateController,true ),
                        const SizedBox(height: 10,),
                        bindInputData(context,"User Cluster",saleCycleController.userClusterUpdateController,true ),

                      ],
                    ),
                  )
              ),
              const SizedBox(height: 15,),

              Obx((){
                return Visibility(
                  visible: saleCycleController.isInfraYes.value,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.grayColor, // Set the border color here
                                width: 1.0, // Adjust the border width if necessary
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Infrastructure Department',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.sisxteen),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindInputData(context,'Name Of Infra Department',saleCycleController.nameofInfradepUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Executive Engineer',saleCycleController.executiveEngineerUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Assistant Engineer',saleCycleController.assistantEngineerController,false ),
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: 15,),
                        Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.grayColor, // Set the border color here
                                width: 1.0, // Adjust the border width if necessary
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Project Details',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.sisxteen),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindInputData(context,'Name Of Project',saleCycleController.nameOfProjectController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Location',saleCycleController.locationController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Time Period To Complete Civil Work',saleCycleController.timePeriodToCompleteWorkController,false ),
                                  const SizedBox(height: 10,),
                                  bindExpectedDateCompletion(context),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Project Value',saleCycleController.projectValueUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Expected Revenue From Furniture etc',saleCycleController.expectedRevenueUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindFurnitureIncludedInCivil(context),
                                ],
                              ),
                            )
                        ),

                        const SizedBox(height: 15,),
                        Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.grayColor, // Set the border color here
                                width: 1.0, // Adjust the border width if necessary
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Customer Details',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.sisxteen),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindInputData(context,'Customer Name',saleCycleController.customerNameController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Contact Person (HOD)/Decision Maker',saleCycleController.contactPersonHODController,false ),
                                ],
                              ),
                            )
                        ),

                        const SizedBox(height: 15,),
                        Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.grayColor, // Set the border color here
                                width: 1.0, // Adjust the border width if necessary
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Contactor Details',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.sisxteen),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindInputData(context,'Name Of Agency/Contractor',saleCycleController.agencyContractorUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Owner Of Contractor',saleCycleController.ownerOfContractorController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Project Site Manager',saleCycleController.siteManagerController,false ),
                                ],
                              ),
                            )
                        ),

                        const SizedBox(height: 15,),
                        Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.grayColor, // Set the border color here
                                width: 1.0, // Adjust the border width if necessary
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Architect Details',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.sisxteen),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindInputData(context,'Name Of Architect Firm',saleCycleController.nameOfArchitecfirmUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Architect',saleCycleController.architectUpdateController,false ),
                                ],
                              ),
                            )
                        ),

                        const SizedBox(height: 15,),
                        Container(
                            margin: EdgeInsets.only(left: 15.0, right: 15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AllColors.grayColor, // Set the border color here
                                width: 1.0, // Adjust the border width if necessary
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Other Details',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.sisxteen),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindItemCategoryDropDown(context),
                                  const SizedBox(height: 10,),
                                  Obx((){
                                    return Visibility(
                                      visible: saleCycleController.IsCatergorySelected.value,
                                      child: Wrap(
                                        spacing: 8.0,
                                        children: saleCycleController.Item_Category_Selected_Infra_list.map((category) {
                                          return Chip(
                                            label: Text(category.categoryName!),
                                            onDeleted: () {
                                              saleCycleController.Item_Category_Selected_Infra_list.remove(category);
                                              if(saleCycleController.Item_Category_Selected_Infra_list.isEmpty){
                                                saleCycleController.IsCatergorySelected.value = false;
                                              }else{
                                                saleCycleController.IsCatergorySelected.value =true;
                                              }
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 10,),
                                  bindDrawingCollected(context),
                                  const SizedBox(height: 10,),
                                  bindDateOfDrawingReceived(context),
                                  const SizedBox(height: 10,),
                                  bindProposalSubmitted(context),
                                  const SizedBox(height: 10,),
                                  bindDateOfProposalSubmission(context),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Value Of Quote',saleCycleController.valueOfQuoteUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindExpectedDateOfOrder(context),
                                  const SizedBox(height: 10,),
                                  bindInaugrationDateOfProject(context),

                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                );
              })

            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget bindIsInfraLead(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        enabled: saleCycleController.isInfraYes.value== true?false:true,
        width: size.width-60,
        controller: saleCycleController.isInfraLeadUpdateController.value,
        label: Text(
          "Is Infra Lead",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.isInfraLeadUpdateController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
          if(saleCycleController.isInfraLeadUpdateController.value.text=="Yes"){
            saleCycleController.isInfraYes.value = true;
          }else{
            //saleCycleController.isInfraLeadValue.value=true;
            saleCycleController.isInfraYes.value=false;
          }
          print("Is Lead ${saleCycleController.isInfraLead.value.text}");

        },
        dropdownMenuEntries:
        saleCycleController.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  bindInputData(BuildContext context,String levelText, TextEditingController controller, bool isReadOnly) {
    var keyBoardType = TextInputType.text;
    if(levelText=='Time Period To Complete Civil Work' ||
        levelText=='Project Value' ||
        levelText=='Expected Revenue From Furniture etc' || levelText == 'Value Of Quote')
    keyBoardType = TextInputType.number;
    return  TextFormField(
      readOnly: isReadOnly,
      controller: controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
          hintText: levelText,
          labelText: levelText,
          contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,
              horizontal: AllFontSize.ten ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),

    );
  }



  bindExpectedDateOfOrder(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller:  saleCycleController.expectedDateOfOrderUpdateController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Expected Date Of Order',
            labelText: 'Expected Date Of Order',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w400,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime? initialDate;
          if (saleCycleController.expectedDateOfOrderUpdateController.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              saleCycleController.expectedDateOfOrderUpdateController.text,
            );
            if (initialDate.isBefore(DateTime.now())) {
              initialDate = DateTime.now();
            }
          } else {
            initialDate = DateTime.now();
          }
          DateTime firstDate = DateTime.now();;
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
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
          var outputFormat = DateFormat('yyyy-MM-dd');
          if (date != null && date != "")
            saleCycleController.expectedDateOfOrderUpdateController.text= outputFormat.format(date);
          /*  else
            saleCycleController.expectedDateOfOrderUpdateController.text =  saleCycleController.expectedDateOfOrderUpdateController.text;*/
        }



    );
  }

  bindDrawingCollected(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width-60,
        controller: saleCycleController.drawingcollectedUpdateController,
        label: Text(
          "Drawing Collected",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.drawingcollectedUpdateController.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();

        },
        dropdownMenuEntries:
        saleCycleController.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindFurnitureIncludedInCivil(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width-60,
        controller: saleCycleController.furnitureIncludedInCivilController,
        label: Text(
          "Furniture Included in Civil Contractor Scope",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.furnitureIncludedInCivilController.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();

        },
        dropdownMenuEntries:
        saleCycleController.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindProposalSubmitted(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width-60,
        controller: saleCycleController.proposalSubmittedUpdateController,
        label: Text(
          "Methodex Proposal Submitted",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w500),
        ),

        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AllColors.primaryDark1,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
        ),
        onSelected: (String? selection) {
          print(selection);
          saleCycleController.proposalSubmittedUpdateController.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        },
        dropdownMenuEntries:
        saleCycleController.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindInaugrationDateOfProject(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.inaugrationDateUpdateController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Inauguration Date Of Project',
            labelText: 'Inauguration Date Of Project',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w400,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime? initialDate;
          if (saleCycleController.inaugrationDateUpdateController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              saleCycleController.inaugrationDateUpdateController.text,
            );
            if (initialDate.isBefore(DateTime.now())) {
              initialDate = DateTime.now();
            }
          } else {
            initialDate = DateTime.now();
          }
          DateTime firstDate = DateTime.now();
          DateTime ending_date = new DateTime(2200);
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
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
            saleCycleController.inaugrationDateUpdateController.text= outputFormat.format(date);
          /*else
            saleCycleController.inaugrationDateUpdateController.text =  saleCycleController.inaugrationDateUpdateController.text;*/
        }



    );
  }

  Widget bindItemCategoryDropDown(context){
    if(saleCycleController.Item_Category_Selected_Infra_list.isNotEmpty){
      saleCycleController.IsCatergorySelected.value = true;
    }
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemCatMasterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return saleCycleController.Item_Category_Infra_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return saleCycleController.Item_Category_Infra_list
            .where((ItemCategoryMstModel option) {
          return option.categoryName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstModel selection) {
        // Update the TextField with the selected
        saleCycleController.ItemCat_type_controller.text =
            _displayItemCatMasterForOption(selection).toString();

        if (!saleCycleController.Item_Category_Selected_Infra_list.contains(selection)) {
          saleCycleController.Item_Category_Selected_Infra_list.add(selection);
          Utils.showToastification('Success', 'Add Successfully');
          saleCycleController.IsCatergorySelected.value = true;
        }else{
          Utils.showErrorToastification('Error', 'Already Selected');
        }

        // saleCycleController.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = saleCycleController.ItemCat_type_controller
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
            hintText: 'Product Category',
            labelText: 'Product Category',

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ItemCategoryMstModel> onSelected,
          Iterable<ItemCategoryMstModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            elevation: 4.0,
            child: Container(
              width: size.width*.7,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final ItemCategoryMstModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.categoryName.toString(),
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

  bindExpectedDateCompletion(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.dateofcompletioneUpdateController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Expected Date Of Completion',
            labelText: 'Expected Date Of Completion',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w400,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime? initialDate;
          if (saleCycleController.dateofcompletioneUpdateController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              saleCycleController.dateofcompletioneUpdateController.text,
            );
            if (initialDate.isBefore(DateTime.now())) {
              initialDate = DateTime.now();
            }

          } else {
            initialDate = DateTime.now();
          }
          DateTime ending_date = new DateTime(2200);
          DateTime firstDate = DateTime.now();;
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1, // Header background color
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          var outputFormat = DateFormat('dd-MM-yyyy');
          if (date != null && date != "")
            saleCycleController.dateofcompletioneUpdateController.text= outputFormat.format(date);
          else
            saleCycleController.dateofcompletioneUpdateController.text = saleCycleController.dateofcompletioneUpdateController.text;
        }

    );
  }

  bindDateOfProposalSubmission(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.dateOfProposalSubmissionController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Date Of Proposal Submission',
            labelText: 'Date Of Proposal Submission',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w400,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime? initialDate;
          if (saleCycleController.dateOfProposalSubmissionController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              saleCycleController.dateOfProposalSubmissionController.text,
            );
            if (initialDate.isBefore(DateTime.now())) {
              initialDate = DateTime.now();
            }

          } else {
            initialDate = DateTime.now();
          }
          DateTime ending_date = new DateTime(2200);
          DateTime firstDate = DateTime.now();;
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1, // Header background color
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          var outputFormat = DateFormat('dd-MM-yyyy');
          if (date != null && date != "")
            saleCycleController.dateOfProposalSubmissionController.text= outputFormat.format(date);
          else
            saleCycleController.dateOfProposalSubmissionController.text = saleCycleController.dateOfProposalSubmissionController.text;
        }

    );
  }

  bindDateOfDrawingReceived(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: saleCycleController.dateOfDrawingReceivedController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten
            ),
            suffixIcon: Icon(Icons.calendar_month),
            hintText: 'Date Of Drawing Received',
            labelText: 'Date Of Drawing Received',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w400,
                fontSize: AllFontSize.sisxteen),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
        onTap: () async {
          DateTime? initialDate;
          if (saleCycleController.dateOfDrawingReceivedController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              saleCycleController.dateOfDrawingReceivedController.text,
            );
            if (initialDate.isBefore(DateTime.now())) {
              initialDate = DateTime.now();
            }

          } else {
            initialDate = DateTime.now();
          }
          DateTime ending_date = new DateTime(2200);
          DateTime firstDate = DateTime.now();;
          FocusScope.of(context).requestFocus(new FocusNode());
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1, // Header background color
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          var outputFormat = DateFormat('dd-MM-yyyy');
          if (date != null && date != "")
            saleCycleController.dateOfDrawingReceivedController.text= outputFormat.format(date);
          else
            saleCycleController.dateOfDrawingReceivedController.text = saleCycleController.dateOfDrawingReceivedController.text;
        }

    );
  }

}