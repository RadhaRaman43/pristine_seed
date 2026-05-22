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
import '../../CRM_Models/AccountMaster_model/Account_Master_model.dart';
import '../../CRM_Models/Contact_Master_modal/Contact_Master_modal/conract_master_modal.dart';
import '../../CRM_Models/TaskMaster_model/Item_Category_Mast_model.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';

class UpdateTaskMstInfraScreen extends StatelessWidget{
  UpdateTaskMstInfraScreen({super.key});
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  Size size=Get.size;
  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;

  static String _displayItemCatMasterForOption(ItemCategoryMstModel option) =>
      option.categoryName!;

  static String _displayAccountNameForOption(AccountMasterModel option) =>
      option.accountName??""+"(${option.accountCode??""})";
  //option.accountCode!;

  static String _displayContactNameForOption(ContactMstGetListModal option) =>
      "${option.contactCode ??""}(${option.contactCode??""})";


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       // TaskMaster_page_controller.clearUpdateController();
       // Get.toNamed(RoutesName.addNewDSARTask_screen);
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
                    TaskMaster_page_controller.gettaskMstInfraUpdate();
                  }, //Text
                ),*/


            ],
          )
      ),
      drawer: CustomDrawer(),
      floatingActionButton: Padding(
      padding: const EdgeInsets.only(left:30),
        child: DefaultButton(
          //text: "${TaskMaster_page_controller.Task_Master_list[0].isInfraLead==1?"Update":"Add"} Infra Details",
          text: "Submit",
          press: (){

              TaskMaster_page_controller.gettaskMstInfraUpdate(TaskMaster_page_controller.Task_Master_list[0].infraLeadNo??"", TaskMaster_page_controller.infraFlag);

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
                        bindInputData(context,"User Region", TaskMaster_page_controller.userRegionUpdateController,true ),
                        const SizedBox(height: 10,),
                        bindInputData(context,"User Cluster",TaskMaster_page_controller.userClusterUpdateController,true ),

                      ],
                    ),
                  )
              ),
              const SizedBox(height: 15,),

              Obx((){
                return Visibility(
                  visible: TaskMaster_page_controller.isInfraYes.value,
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
                                  bindAccountNameDropDown(context,TaskMaster_page_controller.nameofInfradepUpdateController,'Name Of Infra Department',false),
                                  const SizedBox(height: 10,),
                                  bindContactNameDropDown(context,TaskMaster_page_controller.executiveEngineerUpdateController,'Executive Engineer',false),
                                  const SizedBox(height: 10,),
                                  bindContactNameDropDown(context,TaskMaster_page_controller.assistantEngineerController,'Assistant Engineer',false),
                                  
                                  /*bindInputData(context,'Name Of Infra Department',TaskMaster_page_controller.nameofInfradepUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Executive Engineer',TaskMaster_page_controller.executiveEngineerUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Assistant Engineer',TaskMaster_page_controller.assistantEngineerController,false ),*/
                               
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
                                  bindInputData(context,'Name Of Project',TaskMaster_page_controller.nameOfProjectController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Location',TaskMaster_page_controller.locationController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Time Period To Complete Civil Work',TaskMaster_page_controller.timePeriodToCompleteWorkController,false ),
                                  const SizedBox(height: 10,),
                                  bindExpectedDateCompletion(context),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Project Value',TaskMaster_page_controller.projectValueUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Expected Revenue From Furniture etc',TaskMaster_page_controller.expectedRevenueUpdateController,false ),
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
                                  bindAccountNameDropDown(context,TaskMaster_page_controller.customerNameController,'Customer Name',false),
                                  const SizedBox(height: 10,),
                                  bindContactNameDropDown(context,TaskMaster_page_controller.contactPersonHODController,'Contact Person (HOD)/Decision Maker',false),

                                  /*bindInputData(context,'Customer Name',TaskMaster_page_controller.customerNameController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Contact Person (HOD)/Decision Maker',TaskMaster_page_controller.contactPersonHODController,false ),
                               */
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
                                  bindAccountNameDropDown(context,TaskMaster_page_controller.agencyContractorUpdateController,'Name Of Agency/Contractor',false),
                                  const SizedBox(height: 10,),
                                  bindContactNameDropDown(context,TaskMaster_page_controller.ownerOfContractorController,'Owner Of Contractor',false),
                                  const SizedBox(height: 10,),
                                  bindContactNameDropDown(context,TaskMaster_page_controller.siteManagerController,'Project Site Manager',false),
                                  
                                 /* bindInputData(context,'Name Of Agency/Contractor',TaskMaster_page_controller.agencyContractorUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Owner Of Contractor',TaskMaster_page_controller.ownerOfContractorController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Project Site Manager',TaskMaster_page_controller.siteManagerController,false ),*/
                               
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
                                  bindAccountNameDropDown(context,TaskMaster_page_controller.nameOfArchitecfirmUpdateController,'Name Of Architect Firm',false),
                                  const SizedBox(height: 10,),
                                  bindContactNameDropDown(context,TaskMaster_page_controller.architectUpdateController,'Architect',false),
                                  
                                  /*bindInputData(context,'Name Of Architect Firm',TaskMaster_page_controller.nameOfArchitecfirmUpdateController,false ),
                                  const SizedBox(height: 10,),
                                  bindInputData(context,'Architect',TaskMaster_page_controller.architectUpdateController,false ),*/
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
                                      visible: TaskMaster_page_controller.IsCatergorySelected.value,
                                      child: Wrap(
                                        spacing: 8.0,
                                        children: TaskMaster_page_controller.Item_Category_Selected_Infra_list.map((category) {
                                          return Chip(
                                            label: Text(category.categoryName!),
                                            onDeleted: () {
                                              TaskMaster_page_controller.Item_Category_Selected_Infra_list.remove(category);
                                              if(TaskMaster_page_controller.Item_Category_Selected_Infra_list.isEmpty){
                                                TaskMaster_page_controller.IsCatergorySelected.value = false;
                                              }else{
                                                TaskMaster_page_controller.IsCatergorySelected.value =true;
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
                                  bindInputData(context,'Value Of Quote',TaskMaster_page_controller.valueOfQuoteUpdateController,false ),
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
  Widget bindAccountNameDropDown(context, TextEditingController controller1,String labelText, bool readOnly){
    return Autocomplete<AccountMasterModel>(
      displayStringForOption: _displayAccountNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.getAccountMaster(TaskMaster_page_controller.rowsPerPage,"");
        }
        return TaskMaster_page_controller.getAccountMaster(TaskMaster_page_controller.rowsPerPage,textEditingValue.text);
      },
      onSelected: (AccountMasterModel selection) {

        if(labelText=='Name Of Infra Department'){
          TaskMaster_page_controller.nameofInfradepUpdateController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.nameofInfradepUpdate = selection.accountCode??"";
          TaskMaster_page_controller.executiveEngineerUpdateController.text="";
          TaskMaster_page_controller.assistantEngineerController.text="";
          TaskMaster_page_controller.executiveEn="";
          TaskMaster_page_controller.assistantEn="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;
        }
        else if(labelText=='Customer Name'){
          TaskMaster_page_controller.customerNameController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.customerName = selection.accountCode??"";
          TaskMaster_page_controller.contactPersonHODController.text="";
          TaskMaster_page_controller.contactPersonHOD="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;

        }
        else if(labelText=='Name Of Agency/Contractor'){
          TaskMaster_page_controller.agencyContractorUpdateController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.agencyContractorUpdate = selection.accountCode??"";
          TaskMaster_page_controller.ownerOfContractorController.text="";
          TaskMaster_page_controller.ownerOfContractor="";
          TaskMaster_page_controller.siteManagerController.text="";
          TaskMaster_page_controller.siteManager="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;
        }
        else if(labelText=='Name Of Architect Firm'){
          TaskMaster_page_controller.nameOfArchitecfirmUpdateController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.nameOfArchitecfirmUpdate = selection.accountCode??"";
          TaskMaster_page_controller.architectUpdateController.text="";
          TaskMaster_page_controller.architectUpdate="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;
        }

        /*TaskMaster_page_controller.account_code.value=selection.accountCode!;
        TaskMaster_page_controller.account_name.value=selection.accountName!;*/

        TaskMaster_page_controller.getContactMasterList(selection.accountCode!,selection.accountName!);
        TaskMaster_page_controller.pageNumber = 0;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            // controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = controller1.text,
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
            //hintText: labelText,
            labelText: labelText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AccountMasterModel> onSelected,
          Iterable<AccountMasterModel> suggestions) {
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
                  final AccountMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text("${option.accountName!}(${option.accountCode!})"
                        //option.accountName!+"(${option.accountCode!})",
                        ,
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
    );
  }

  Widget bindContactNameDropDown(context, TextEditingController controller1, String labelText, bool readOnly){
    return Autocomplete<ContactMstGetListModal>(
      displayStringForOption: _displayContactNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.contact_master_list;
        }
        return TaskMaster_page_controller.getContactMasterList("","");
        /*return TaskMaster_page_controller.infra_contact_master_list
            .where((ContactMstGetListModal option) {
          return option.contactName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (ContactMstGetListModal selection) {
        if(labelText=='Executive Engineer') {
          TaskMaster_page_controller.executiveEngineerUpdateController.text =
              _displayContactNameForOption(selection).toString();
          TaskMaster_page_controller.executiveEn = selection.contactCode ?? "";
        }
        else if(labelText=='Assistant Engineer'){
          TaskMaster_page_controller.assistantEngineerController.text =
              _displayContactNameForOption(selection).toString();
          TaskMaster_page_controller.assistantEn = selection.contactCode ?? "";
        }
        else if(labelText=='Contact Person (HOD)/Decision Maker'){
          TaskMaster_page_controller.contactPersonHODController.text =
              _displayContactNameForOption(selection).toString();
          TaskMaster_page_controller.contactPersonHOD= selection.contactCode ?? "";
        }
        else if(labelText=='Owner Of Contractor'){
          TaskMaster_page_controller.ownerOfContractorController.text =
              _displayContactNameForOption(selection).toString();
          TaskMaster_page_controller.ownerOfContractor= selection.contactCode ?? "";
        }
        else if(labelText=='Project Site Manager'){
          TaskMaster_page_controller.siteManagerController.text =
              _displayContactNameForOption(selection).toString();
          TaskMaster_page_controller.siteManager= selection.contactCode ?? "";
        }
        else if(labelText=='Architect'){
          TaskMaster_page_controller.architectUpdateController.text =
              _displayContactNameForOption(selection).toString();
          TaskMaster_page_controller.architectUpdate= selection.contactCode ?? "";
        }

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        print("print controller ${controller1.text}");
        return TextField(
          onTap: (){
            //controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = controller1.text,
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
            //hintText: labelText,
            labelText: labelText,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ContactMstGetListModal> onSelected,
          Iterable<ContactMstGetListModal> suggestions) {
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
                  final ContactMstGetListModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text("${option.contactName ?? ""}(${option.contactCode ??""})",
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


  /*Widget bindAccountNameDropDown(context, TextEditingController controller1,String labelText, bool readOnly){
    return Autocomplete<AccountMasterModel>(
      displayStringForOption: _displayAccountNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.getAccountMaster(TaskMaster_page_controller.rowsPerPage,"");
        }
        return TaskMaster_page_controller.getAccountMaster(TaskMaster_page_controller.rowsPerPage,textEditingValue.text);
      },
      onSelected: (AccountMasterModel selection) {

        if(labelText=='Name Of Infra Department'){
          TaskMaster_page_controller.nameofInfradepUpdateController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.executiveEngineerUpdateController.text="";
          TaskMaster_page_controller.assistantEngineerController.text="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;
        }
        else if(labelText=='Customer Name'){
          TaskMaster_page_controller.customerNameController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.contactPersonHODController.text="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;

        }
        else if(labelText=='Name Of Agency/Contractor'){
          TaskMaster_page_controller.agencyContractorUpdateController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.ownerOfContractorController.text="";
          TaskMaster_page_controller.siteManagerController.text="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;
        }
        else if(labelText=='Name Of Architect Firm'){
          TaskMaster_page_controller.nameOfArchitecfirmUpdateController.text =
              _displayAccountNameForOption(selection).toString();
          TaskMaster_page_controller.architectUpdateController.text="";
          TaskMaster_page_controller.isInfraYes.value = false;
          TaskMaster_page_controller.isInfraYes.value = true;
        }

        *//*TaskMaster_page_controller.account_code.value=selection.accountCode!;
        TaskMaster_page_controller.account_name.value=selection.accountName!;*//*
        TaskMaster_page_controller.getContactMasterList(selection.accountCode!,selection.accountName!);
        TaskMaster_page_controller.pageNumber = 0;

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            //controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = controller1.text,
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
            //hintText: labelText,
            labelText: labelText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<AccountMasterModel> onSelected,
          Iterable<AccountMasterModel> suggestions) {
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
                  final AccountMasterModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        //option.accountName!+"(${option.accountCode!})",
                        option.accountCode!,
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
    );
  }

  Widget bindContactNameDropDown(context, TextEditingController controller1, String labelText, bool readOnly){
    return Autocomplete<ContactMstGetListModal>(
      displayStringForOption: _displayContactNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.contact_master_list;
        }
        return TaskMaster_page_controller.contact_master_list
            .where((ContactMstGetListModal option) {
          return option.contactName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ContactMstGetListModal selection) {
        if(labelText=='Executive Engineer') {
          TaskMaster_page_controller.executiveEngineerUpdateController.text =
              _displayContactNameForOption(selection).toString();
        }
        else if(labelText=='Assistant Engineer'){
          TaskMaster_page_controller.assistantEngineerController.text =
              _displayContactNameForOption(selection).toString();
        }
        else if(labelText=='Contact Person (HOD)/Decision Maker'){
          TaskMaster_page_controller.contactPersonHODController.text =
              _displayContactNameForOption(selection).toString();
        }
        else if(labelText=='Owner Of Contractor'){
          TaskMaster_page_controller.ownerOfContractorController.text =
              _displayContactNameForOption(selection).toString();
        }
        else if(labelText=='Project Site Manager'){
          TaskMaster_page_controller.siteManagerController.text =
              _displayContactNameForOption(selection).toString();
        }
        else if(labelText=='Architect'){
          TaskMaster_page_controller.architectUpdateController.text =
              _displayContactNameForOption(selection).toString();
        }

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        print("print controller ${controller1.text}");
        return TextField(
          onTap: (){
            //controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller..text = controller1.text,
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
            //hintText: labelText,
            labelText: labelText,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ContactMstGetListModal> onSelected,
          Iterable<ContactMstGetListModal> suggestions) {
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
                  final ContactMstGetListModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.contactCode.toString(),
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
  */

  Widget bindIsInfraLead(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        enabled: TaskMaster_page_controller.isInfraYes.value== true?false:true,
        width: size.width-60,
        controller: TaskMaster_page_controller.isInfraLeadUpdateController.value,
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
          TaskMaster_page_controller.isInfraLeadUpdateController.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
          if(TaskMaster_page_controller.isInfraLeadUpdateController.value.text=="Yes"){
            TaskMaster_page_controller.isInfraYes.value = true;
          }else{
            //TaskMaster_page_controller.isInfraLeadValue.value=true;
            TaskMaster_page_controller.isInfraYes.value=false;
          }
          print("Is Lead ${TaskMaster_page_controller.isInfraLead.value.text}");

        },
        dropdownMenuEntries:
        TaskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );

  }

  bindExpectedDateOfOrder(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller:  TaskMaster_page_controller.expectedDateOfOrderUpdateController,
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
          if (TaskMaster_page_controller.expectedDateOfOrderUpdateController.text.isNotEmpty) {
            initialDate = DateFormat('yyyy-MM-dd').parse(
              TaskMaster_page_controller.expectedDateOfOrderUpdateController.text,
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
            TaskMaster_page_controller.expectedDateOfOrderUpdateController.text= outputFormat.format(date);
          /*  else
            TaskMaster_page_controller.expectedDateOfOrderUpdateController.text =  TaskMaster_page_controller.expectedDateOfOrderUpdateController.text;*/
        }



    );
  }

  bindDrawingCollected(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width-60,
        controller: TaskMaster_page_controller.drawingcollectedUpdateController,
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
          TaskMaster_page_controller.drawingcollectedUpdateController.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();

        },
        dropdownMenuEntries:
        TaskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
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
        controller: TaskMaster_page_controller.furnitureIncludedInCivilController,
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
          TaskMaster_page_controller.furnitureIncludedInCivilController.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();

        },
        dropdownMenuEntries:
        TaskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
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
        controller: TaskMaster_page_controller.proposalSubmittedUpdateController,
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
          TaskMaster_page_controller.proposalSubmittedUpdateController.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
        },
        dropdownMenuEntries:
        TaskMaster_page_controller.isInfraLeadList.map<DropdownMenuEntry<String>>((String e) {
          return DropdownMenuEntry<String>(value: e, label: e!,style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(AllColors.primaryDark1),));
        }).toList(),
      ),
    );
  }

  bindInaugrationDateOfProject(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: TaskMaster_page_controller.inaugrationDateUpdateController,
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
          if (TaskMaster_page_controller.inaugrationDateUpdateController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              TaskMaster_page_controller.inaugrationDateUpdateController.text,
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
            TaskMaster_page_controller.inaugrationDateUpdateController.text= outputFormat.format(date);
          /*else
            TaskMaster_page_controller.inaugrationDateUpdateController.text =  TaskMaster_page_controller.inaugrationDateUpdateController.text;*/
        }



    );
  }


  Widget bindItemCategoryDropDown(context){
    if(TaskMaster_page_controller.Item_Category_Selected_Infra_list.isNotEmpty){
      TaskMaster_page_controller.IsCatergorySelected.value = true;
    }
    return Autocomplete<ItemCategoryMstModel>(
      displayStringForOption: _displayItemCatMasterForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return TaskMaster_page_controller.Item_Category_Infra_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return TaskMaster_page_controller.Item_Category_Infra_list
            .where((ItemCategoryMstModel option) {
          return option.categoryName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstModel selection) {
        // Update the TextField with the selected
        TaskMaster_page_controller.ItemCat_type_controller.text =
            _displayItemCatMasterForOption(selection).toString();

        if (!TaskMaster_page_controller.Item_Category_Selected_Infra_list.contains(selection)) {
          TaskMaster_page_controller.Item_Category_Selected_Infra_list.add(selection);
          Utils.showToastification('Success', 'Add Successfully');
          TaskMaster_page_controller.IsCatergorySelected.value = true;
        }else{
          Utils.showErrorToastification('Error', 'Already Selected');
        }

        // TaskMaster_page_controller.AccountOwner = selection.loginEmailId!;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onTap: (){
            controller.clear();
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = TaskMaster_page_controller.ItemCat_type_controller
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
        controller: TaskMaster_page_controller.dateofcompletioneUpdateController,
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
          if (TaskMaster_page_controller.dateofcompletioneUpdateController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              TaskMaster_page_controller.dateofcompletioneUpdateController.text,
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
            TaskMaster_page_controller.dateofcompletioneUpdateController.text= outputFormat.format(date);
          else
            TaskMaster_page_controller.dateofcompletioneUpdateController.text = TaskMaster_page_controller.dateofcompletioneUpdateController.text;
        }

    );
  }

  bindDateOfProposalSubmission(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: TaskMaster_page_controller.dateOfProposalSubmissionController,
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
          if (TaskMaster_page_controller.dateOfProposalSubmissionController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              TaskMaster_page_controller.dateOfProposalSubmissionController.text,
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
            TaskMaster_page_controller.dateOfProposalSubmissionController.text= outputFormat.format(date);
          else
            TaskMaster_page_controller.dateOfProposalSubmissionController.text = TaskMaster_page_controller.dateOfProposalSubmissionController.text;
        }

    );
  }

  bindDateOfDrawingReceived(BuildContext context) {
    return TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: TaskMaster_page_controller.dateOfDrawingReceivedController,
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
          if (TaskMaster_page_controller.dateOfDrawingReceivedController.text.isNotEmpty) {
            initialDate = DateFormat('dd-MM-yyyy').parse(
              TaskMaster_page_controller.dateOfDrawingReceivedController.text,
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
            TaskMaster_page_controller.dateOfDrawingReceivedController.text= outputFormat.format(date);
          else
            TaskMaster_page_controller.dateOfDrawingReceivedController.text = TaskMaster_page_controller.dateOfDrawingReceivedController.text;
        }

    );
  }

}