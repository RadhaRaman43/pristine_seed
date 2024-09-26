import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_font_size.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../view/custom_drawer.dart';
import '../../CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';

class UpdateTaskMstInfraScreen extends StatelessWidget{
  UpdateTaskMstInfraScreen({super.key});
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  Size size=Get.size;
  static String _displayCustomerNeedIdentityStatusForOption(String option) =>
      option;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       // TaskMaster_page_controller.clearUpdateController();
        Get.toNamed(RoutesName.addNewDSARTask_screen);
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
               ActionChip(
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
                ),


            ],
          )
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              bindIsInfraLead(context),
              SizedBox(height: 10,),
              binduserRegion(context),
              SizedBox(height: 10,),
              binduserCluster(context),
              SizedBox(height: 10,),
              bindProjectValue(context),
              SizedBox(height: 10,),
              bindExpectedDateOfOrder(context),
              SizedBox(height: 10,),
              bindDrawingCollected(context),
              SizedBox(height: 10,),
              bindProposalSubmitted(context),
              SizedBox(height: 10,),
              bindInaugrationDateOfProject(context),
              SizedBox(height: 10,),
              bindArchitect(context),
              SizedBox(height: 10,),
              bindExcecutiveEngineer(context),
              SizedBox(height: 10,),
              bindNameOfArchitectFilm(context),
              SizedBox(height: 10,),
              bindNameOfInfraDepartment(context),
              SizedBox(height: 10,),
              bindNameOfAgencyContractor(context),
              SizedBox(height: 10,),
              bindExpectedRevene(context),
              SizedBox(height: 10,),
              bindValueOfQuote(context),
              SizedBox(height: 10,),
              bindExpectedDateCompletion(context),
              SizedBox(height: 10,),

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
        enabled: false,
        width: size.width-30,
        controller: TaskMaster_page_controller.isInfraLeadUpdateController,
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
          TaskMaster_page_controller.isInfraLead.value.text =
              _displayCustomerNeedIdentityStatusForOption(selection!).toString();
          if(TaskMaster_page_controller.isInfraLead.value.text=="Yes"){
            TaskMaster_page_controller.isInfraLeadValue.value=false;
          }else{
            TaskMaster_page_controller.isInfraLeadValue.value=true;
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
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
     padding: EdgeInsets.only(left: 15.0, right: 15.0),
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
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
      ),
    );
  }

  bindExpectedDateOfOrder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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



      ),
    );
  }

  bindDrawingCollected(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width-30,
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

  bindProposalSubmitted(BuildContext context) {
    return Container(
      child: DropdownMenu<String>(
        width: size.width-30,
        controller: TaskMaster_page_controller.proposalSubmittedUpdateController,
        label: Text(
          "Proposal Submitted",
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
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
              initialDate = DateFormat('yyyy-MM-dd').parse(
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
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              TaskMaster_page_controller.inaugrationDateUpdateController.text= outputFormat.format(date);
            /*else
              TaskMaster_page_controller.inaugrationDateUpdateController.text =  TaskMaster_page_controller.inaugrationDateUpdateController.text;*/
          }



      ),
    );
  }

  bindArchitect(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
      ),
    );
  }

  bindExcecutiveEngineer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
      ),
    );
  }

  bindNameOfArchitectFilm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
      ),
    );
  }

  bindNameOfInfraDepartment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
      ),
    );
  }

  bindNameOfAgencyContractor(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: TaskMaster_page_controller.agencyContractorUpdateController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Name Of Agency Contractor',
            labelText: 'Name Of Agency Contractor',
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
      ),
    );
  }

  bindExpectedRevene(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
        cursorColor:AllColors.primaryDark1 ,
        controller: TaskMaster_page_controller.expectedRevenueUpdateController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.ten),
            hintText: 'Expected Revenue',
            labelText: 'Expected Revenue',
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
      ),
    );
  }

  bindValueOfQuote(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
      ),
    );
  }

  bindExpectedDateCompletion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: TextField(
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
              initialDate = DateFormat('yyyy-MM-dd').parse(
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
            var outputFormat = DateFormat('yyyy-MM-dd');
            if (date != null && date != "")
              TaskMaster_page_controller.dateofcompletioneUpdateController.text= outputFormat.format(date);
            else
              TaskMaster_page_controller.dateofcompletioneUpdateController.text = TaskMaster_page_controller.dateofcompletioneUpdateController.text;
          }

      ),
    );
  }

}