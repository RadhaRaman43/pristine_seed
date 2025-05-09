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
                      SizedBox(height: 10,),
                      binduserRegion(context),
                      SizedBox(height: 10,),
                      binduserCluster(context),
                    ],
                  ),
                )
              ),
              SizedBox(height: 15,),

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
                                  bindNameOfInfraDepartment(context),
                                  SizedBox(height: 10,),
                                  bindExcecutiveEngineer(context),
                                  SizedBox(height: 10,),
                                  bindAssiEngineer(context)
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
                                  bindNameOfProject(context),
                                  SizedBox(height: 10,),
                                  bindLocation(context),
                                  SizedBox(height: 10,),
                                  bindTimePeriodToComplete(context),
                                  SizedBox(height: 10,),
                                  bindExpectedDateCompletion(context),
                                  SizedBox(height: 10,),
                                  bindProjectValue(context),
                                  SizedBox(height: 10,),
                                  bindExpectedRevene(context),
                                  SizedBox(height: 10,),
                                  bindFurnitureIncludedInCivil(context),
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
                                  bindCustomerName(context),
                                  SizedBox(height: 10,),
                                  bindContactPersonHOD(context),

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
                                  bindNameOfAgencyContractor(context),
                                  SizedBox(height: 10,),
                                  bindOwnerOfContrctor(context),
                                  SizedBox(height: 10,),
                                  bindSiteManager(context)

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
                                  bindNameOfArchitectFilm(context),
                                  SizedBox(height: 10,),
                                  bindArchitect(context),

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
                                  SizedBox(height: 10,),

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


                                  SizedBox(height: 10,),
                                  bindDrawingCollected(context),
                                  SizedBox(height: 10,),
                                  bindDateOfDrawingReceived(context),
                                  SizedBox(height: 10,),
                                  bindProposalSubmitted(context),
                                  SizedBox(height: 10,),
                                  bindDateOfProposalSubmission(context),
                                  SizedBox(height: 10,),
                                  bindValueOfQuote(context),
                                  SizedBox(height: 10,),
                                  bindExpectedDateOfOrder(context),
                                  SizedBox(height: 10,),
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

  Widget binduserRegion(BuildContext context) {
    return  Container(
     // padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: TextFormField(
        readOnly: true,
        controller: TaskMaster_page_controller.userRegionUpdateController,
        decoration: InputDecoration(
            hintText: "User Region",
            labelText: "User Region",
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,
                horizontal: AllFontSize.ten ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),

      ),
    );
  }

 Widget binduserCluster(BuildContext context) {
   return  Container(
     //padding: EdgeInsets.only(left: 15.0, right: 15.0),
     child: TextFormField(
       readOnly: true,
       controller: TaskMaster_page_controller.userClusterUpdateController,
       decoration: InputDecoration(
           hintText: "User Cluster",
           labelText: "User Cluster",
           contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.ten,
               horizontal: AllFontSize.ten ),
           border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10)
           )
       ),

     ),
   );
  }

  Widget bindProjectValue(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.projectValueUpdateController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Project Value',
          labelText: 'Project Value',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget bindNameOfProject(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.nameOfProjectController,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Name Of Project',
          labelText: 'Name Of Project',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget bindCustomerName(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.customerNameController,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Customer Name',
          labelText: 'Customer Name',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget bindLocation(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.locationController,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Location',
          labelText: 'Location',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  Widget bindTimePeriodToComplete(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.timePeriodToCompleteWorkController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Time Period To Complete Civil Work',
          labelText: 'Time Period To Complete Civil Work',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
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

  bindAssiEngineer(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.assistantEngineerController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Assistant Engineer',
          labelText: 'Assistant Engineer',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindArchitect(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.architectUpdateController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Architect',
          labelText: 'Architect',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindExcecutiveEngineer(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.executiveEngineerUpdateController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Executive Engineer',
          labelText: 'Executive Engineer',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindContactPersonHOD(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.contactPersonHODController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Contact Person (HOD)/Decision Maker',
          labelText: 'Contact Person (HOD)/Decision Maker',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindNameOfArchitectFilm(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.nameOfArchitecfirmUpdateController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Name Of Architect Firm',
          labelText: 'Name Of Architect Firm',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindNameOfInfraDepartment(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.nameofInfradepUpdateController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Name Of Infra Department',
          labelText: 'Name Of Infra Department',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindNameOfAgencyContractor(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.agencyContractorUpdateController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Name Of Agency/Contractor',
          labelText: 'Name Of Agency/Contractor',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindOwnerOfContrctor(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.ownerOfContractorController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Owner Of Contractor',
          labelText: 'Owner Of Contractor',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindSiteManager(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.siteManagerController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Project Site Manager',
          labelText: 'Project Site Manager',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }

  bindExpectedRevene(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.expectedRevenueUpdateController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Expected Revenue From Furniture etc',
          labelText: 'Expected Revenue From Furniture etc',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
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

  bindValueOfQuote(BuildContext context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: TaskMaster_page_controller.valueOfQuoteUpdateController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: AllFontSize.two, horizontal: AllFontSize.ten),
          hintText: 'Value Of Quote',
          labelText: 'Value Of Quote',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
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