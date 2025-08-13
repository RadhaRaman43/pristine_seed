import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/emp_infor_system/emp_mark_leave_request_vm.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_pending_for_approval_vm.dart';



import '../CRM_Directory/CRM_VIewModels/Bussiness_Tour_Plan_Vm/BusinessPlanTour_Vm.dart';
import '../CRM_Directory/CRM_VIewModels/Bussiness_Tour_Plan_Vm/Business_Tour_Approval_Vm.dart';
import '../CRM_Directory/CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../CRM_Directory/CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../CRM_Directory/CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../CRM_Directory/CRM_VIewModels/contact_master_vm/contact_master_vm/all_contact_master_vm.dart';
import '../CRM_Directory/CRM_VIewModels/emp_infor_system/leave_request_approval_vm.dart';
import '../CRM_Directory/CRM_VIewModels/emp_infor_system/mark_attendance_view_modal.dart';
import '../CRM_Directory/CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/pending_Draft_Quote_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_competitor_product_infor_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';
import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';
import '../constants/static_methods.dart';
import '../locat_database/databaseHelper.dart';
import '../models/loginModel/login_model.dart';
import '../reources/routes/routes_name.dart';
import '../viewModel/SessionManagment/session_managment.dart';
import '../viewModel/home_vm/HomeViewModel.dart';
import '../viewModel/service_managment_vm_directory/dashboard_vm/dashboard_vm.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _Drawer();
}



class _Drawer extends State<CustomDrawer> {
  SessionManagement sessionManagement = SessionManagement();
  final home_vm = Get.put(HomeViewModel());
  final dashBoard_vm = Get.put(DashBoardViewModel());
  List<Menu> globalMenuList = [];
  List<Children> globalchildList = [];
  String name = '';
  String email = '';
  String title2 = '';
  Size size = Get.size;



  int IsCRM =0;



  //todo crm....

/*  final accountMaster_page_controller=Get.put(Accountmastervm());
  final contact_vm_controller = Get.put(ContactMasterVM());
  final TaskMaster_page_controller=Get.put(Taskmastervm());
  final TaskApproval_page_controller=Get.put(TaskApprovalvm());
  final saleCycleController=Get.put(SalesCycleVm());
 *//* final quoteApprovalController=Get.put(QuoteApprovalListVm());*//*
  var allContactMastercontroller=Get.put(AllContactMasterVm());*/
  DatabaseHelper crmDatabase = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AllColors.primaryDark1,
      width: size.width * 0.8,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 330,
              height: size.height * .42 ,
              decoration: BoxDecoration(
                color: AllColors.primaryDark1,
              ),
              // width: double.infinity,
              child: DrawerHeader(
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: InkWell(
                          onTap: () {
                            Get.offAllNamed(RoutesName.homeScreen);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            child: ClipOval(
                              child: Image.asset("assests/images/pristine_pfulfill.png")
                             //Image.network(dashBoard_vm.imageUrl.toString(),height: 40,width: 40,fit: BoxFit.cover,) ,
                            ),
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100, // Set your desired width here
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //todo comment notification.....

                              /*Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.notification_add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),*/

                              SizedBox(width: size.width * .02,),

                              bindprofileMenu(),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                           // margin: EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  height:120,
                                  width:120,
                                  decoration: BoxDecoration(
                                   border: Border.all(color: Colors.white,width: 2),
                                    borderRadius: BorderRadius.circular(80)
                                  ),
                                  child: ClipOval(
                                    child: Image.network(dashBoard_vm.imageUrl.toString(),width: 90,
                                      height: 90,  fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  name.toUpperCase(),
                                  style: GoogleFonts.poppins(
                                      fontSize: AllFontSize.fourtine,
                                      fontWeight: FontWeight.w600,
                                      color: AllColors.whiteColor),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  width: size.width*.7,
                                  child: Text(
                                    email,
                                    style: GoogleFonts.poppins(
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w600,
                                        color: AllColors.whiteColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(height: 1,),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                height: size.height*.61,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: globalMenuList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String title = globalMenuList[index].title.toString();
                    return SingleChildScrollView(
                      child: ExpansionTile(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, cindex) {
                                  String cTitle = globalMenuList[index]
                                      .children![cindex]!
                                      .title
                                      .toString();

                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: ListTile(
                                        onTap: () async {
                                          sessionManagement.setCountry(cTitle);
                                          switch (cTitle) {
                                            case 'Installation Request':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              Get.toNamed(RoutesName.installation_screen,preventDuplicates: false);
                                              home_vm.openMenu(cTitle, iconData);
                                              Navigator.of(context);
                                          /*home_vm.openMenu(cTitle,
                                                  Icon(_getChildIconForIndex(index)))*/;

                                              break;
                                            case 'Corrective Request':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.corrective_screen,preventDuplicates: false);

                                              Navigator.of(context);
                                              break;

                                            case 'Preventive Request':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.preventive_screen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Customer Complain':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.complain_customer_page,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Check In/Out':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                             home_vm.openMenu(cTitle, iconData);
                                               Get.toNamed(RoutesName.checkIn_screen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Check In':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.checkInApproval,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'User Expense':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.myExpenseScreen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Expense':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.expenseApprovarScreen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;


                                            case 'User Route':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.showRouteScreen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Return Indent':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                               Get.toNamed(RoutesName.returnIndentScreen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;
                                            case 'Order List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.order_screen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Orders Approval':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.order_approval_screen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;

                                            case 'Indent List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.indentListscreen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;


                                            case 'Bulk Indent List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.bulk_indent_screen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;


                                            case 'User Inventory':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.toNamed(RoutesName.service_inventory_screen,preventDuplicates: false);
                                              Navigator.of(context);
                                              break;


                                              //todo crm routing.....


                                            case 'Accounts Master':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<Accountmastervm>();
                                              var controller=Get.put(Accountmastervm());
                                              //Get.offAllNamed(RoutesName.accountMaster_screen,);
                                              Get.toNamed(RoutesName.accountMaster_screen,);
                                            /*  accountMaster_page_controller.clearController();
                                              accountMaster_page_controller.pageNumber = 0;
                                              accountMaster_page_controller.getAccountMaster(0 ,accountMaster_page_controller.IsActive_controller.text);*/
                                              Navigator.of(context);
                                              break;

                                            case 'Contacts Master':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<ContactMasterVM>();
                                              var controller=Get.put(ContactMasterVM());
                                              //Get.offAllNamed(RoutesName.contactMaster_screen);
                                             /* contact_vm_controller.clearAllFilterContoller();
                                              contact_vm_controller.pageNumber = 0;*/
                                              Get.toNamed(RoutesName.contactMaster_screen);
                                              //contact_vm_controller.getContactMasterList(0,"","","");
                                              Navigator.of(context);
                                              break;

                                            case 'Account Draft':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<Accountmastervm>();
                                              var controller=Get.put(Accountmastervm());
                                              //accountMaster_page_controller.Account_Master_Draft_list  = await crmDatabase.getItems();
                                              // print('DraftListsize...${accountMaster_page_controller.Account_Master_Draft_list[1].address}');
                                           /*   accountMaster_page_controller.clearFilterController();
                                              accountMaster_page_controller.pageNumber = 0;
                                              accountMaster_page_controller.getDraftAccountMaster(accountMaster_page_controller.pageNumber ,accountMaster_page_controller.is_Active.toString())*/;
                                              Get.toNamed(RoutesName.Draft_item_list);
                                              Navigator.of(context);
                                              break;

                                            case 'All Contacts Master':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<AllContactMasterVm>();
                                              var controller=Get.put(AllContactMasterVm());
                                              //accountMaster_page_controller.Account_Master_Draft_list  = await crmDatabase.getItems();
                                              // print('DraftListsize...${accountMaster_page_controller.Account_Master_Draft_list[1].address}');
                                            /*  allContactMastercontroller.pageNumber = 0;
                                              allContactMastercontroller.getContactMasterAllList(allContactMastercontroller.pageNumber);*/
                                              Get.toNamed(RoutesName.allContactMasterScreen);
                                              Navigator.of(context);
                                              break;

                                            case 'Tasks':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<Taskmastervm>();
                                              var controller=Get.put(Taskmastervm());
                                              //Get.offAllNamed(RoutesName.taskMaster_screen);
                                             // TaskMaster_page_controller.isInfraLeadFilterController.text = "All";
                                             /* TaskMaster_page_controller.SaleCycleActive_Controller.text = "All";
                                              TaskMaster_page_controller.date_filter.value = "Today";
                                              TaskMaster_page_controller.is_done.value = 0;
                                              TaskMaster_page_controller.filter.value = "Running";
                                              TaskMaster_page_controller.resetAllFieldOfFilter();
                                              accountMaster_page_controller.FromPage.value = '';
                                              contact_vm_controller.FromPage.value ='';
                                              TaskMaster_page_controller.pageNumber = 0;*/
                                              Get.toNamed(RoutesName.taskMaster_screen);
                                              //TaskMaster_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), '', '', '',TaskMaster_page_controller.date_filter, TaskMaster_page_controller.is_done.value);
                                              Navigator.of(context);
                                              break;
                                            case 'Task Approval List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<TaskApprovalvm>();
                                             /* TaskApproval_page_controller.resetAllFieldOfFilter();
                                              TaskApproval_page_controller.pageNumber = 0;*/
                                              var controller=Get.put(TaskApprovalvm());
                                              Get.toNamed(RoutesName.taskApproval_List);
                                              //TaskApproval_page_controller.getTaskMaster(0, TaskMaster_page_controller.is_Active.toString(), '','');
                                              Navigator.of(context);
                                              break;
                                            case 'Sales Cycle':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<SalesCycleVm>();
                                              var controller=Get.put(SalesCycleVm());
                                            /*  accountMaster_page_controller.FromPage.value = '';
                                              contact_vm_controller.FromPage.value ='';
                                              saleCycleController.filterQuoteAcceptedFlag.value="Open";
                                              saleCycleController.clearAllFieldOfFilter();
                                              saleCycleController.pageNumber = 0;*/
                                              Get.toNamed(RoutesName.salesCycleScreen,);
                                              //saleCycleController.getsalesCycleData(saleCycleController.pageNumber, "", "",'');
                                              Navigator.of(context);
                                              break;

                                            case 'Quote Approval List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<QuoteApprovalListVm>();
                                              final quoteApprovalController=Get.put(QuoteApprovalListVm());
                                             /* quoteApprovalController.pageNumberForQuote = 0;
                                              quoteApprovalController.getQuoteHeaderData(0);*/
                                              Get.toNamed(RoutesName.quoteApprovalListScreen,);
                                              Navigator.of(context);
                                              break;

                                            /*case 'Mark Leave':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<MarkAttendanceViewmodel>();
                                              MarkAttendanceViewmodel employeeMarkLeaveController=Get.put(MarkAttendanceViewmodel());
                                              Get.toNamed(RoutesName.empMarkLeaveScreen,);
                                              Navigator.of(context);
                                              break;*/
                                            case 'Mark Leave Request':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<EmpMarkLeaveRequestVm>();
                                              EmpMarkLeaveRequestVm employeeMarkLeaveController=Get.put(EmpMarkLeaveRequestVm());
                                              Get.toNamed(RoutesName.empMarkLeaveRequestScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'Leave Request Approval':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<LeaveRequestApprovalVm>();
                                              LeaveRequestApprovalVm employeeMarkLeaveController=Get.put(LeaveRequestApprovalVm());
                                              Get.toNamed(RoutesName.empMarkLeaveRequestApprovalScreen,);
                                              Navigator.of(context);
                                              break;


                                            case 'Sales Cycle Approval List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<SalesCyclePendingForApprovalVm>();
                                              SalesCyclePendingForApprovalVm employeeMarkLeaveController=Get.put(SalesCyclePendingForApprovalVm());
                                              //employeeMarkLeaveController.getsalesCycleData(employeeMarkLeaveController.pageNumber,);
                                              Get.toNamed(RoutesName.salesCyclePendingForApprovalListScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'Pending Draft Quote':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<PendingDraftQuoteVm>();
                                              PendingDraftQuoteVm PendingDraftQuoteController=Get.put(PendingDraftQuoteVm("PENDING & PENDING FOR APPROVAL"));
                                            /*  pendingDraftQuoteController.pageNumberForQuote=0;
                                              pendingDraftQuoteController.getPendingDraftQuoteList(0);*/
                                              Get.toNamed(RoutesName.pendingDraftQuoteScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'Approved / Rejected Quote':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<PendingDraftQuoteVm>();
                                              PendingDraftQuoteVm PendingDraftQuoteController=Get.put(PendingDraftQuoteVm("APPROVED & REJECTED"));
                                              Get.toNamed(RoutesName.approvedRejectedQuoteScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'All SPR Mapping Line Items':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<PendingDraftQuoteVm>();
                                              PendingDraftQuoteVm PendingDraftQuoteController=Get.put(PendingDraftQuoteVm("ALLSPRMAPPING"));
                                              Get.toNamed(RoutesName.allSPRMappingScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'Sales Cycle Competitor List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<SalesCycleCompetitorProductInforVm>();
                                              SalesCycleCompetitorProductInforVm PendingDraftQuoteController=Get.put(SalesCycleCompetitorProductInforVm());
                                              Get.toNamed(RoutesName.salesCycleCompetitorProductInforScreen,);
                                              Navigator.of(context);
                                              break;


                                            case 'All Quote':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<PendingDraftQuoteVm>();
                                              PendingDraftQuoteVm PendingDraftQuoteController=Get.put(PendingDraftQuoteVm("All"));
                                              Get.toNamed(RoutesName.allQuoteScreenScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'All Quote Line Items':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<PendingDraftQuoteVm>();
                                              PendingDraftQuoteVm PendingDraftQuoteController=Get.put(PendingDraftQuoteVm("ALLQuoteLineItems"));
                                              Get.toNamed(RoutesName.allQuoteLineItemScreen,);
                                              Navigator.of(context);
                                              break;

                                            case 'Business Tour Plan':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<BusinessPlanTourViewModel>();
                                              BusinessPlanTourViewModel BusinessTourPlanController=Get.put(BusinessPlanTourViewModel());
                                              Get.toNamed(RoutesName.BusinessTourPlanScreen);
                                              Navigator.of(context);
                                              break;

                                            case 'Business Tour Approval List':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<BusinessTourApprovalVm>();
                                              BusinessTourApprovalVm BusinessTourApprovalController=Get.put(BusinessTourApprovalVm());
                                              Get.toNamed(RoutesName.BusinessTourApprovalListScreen);
                                              Navigator.of(context);
                                              break;

                                            case 'Approved / Rejected Business Tour Plan':
                                              IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                              home_vm.openMenu(cTitle, iconData);
                                              Get.delete<BusinessTourApprovalVm>();
                                              BusinessTourApprovalVm BusinessTourApprovalController=Get.put(BusinessTourApprovalVm());
                                              Get.toNamed(RoutesName.BusinessTourApproveRejectListScreen);
                                              Navigator.of(context);
                                              break;


                                          }
                                        },
                                        leading: Icon(
                                          StaticMethod.getChildIconForIndex(cTitle),
                                          color: AllColors.whiteColor,
                                        ),
                                        title: Text(
                                          cTitle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: AllColors.whiteColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                //itemCount: globalMenuList.length,
                                itemCount:
                                    globalMenuList[index].children!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                            ],
                          ),
                        ],
                        leading: Icon(
                         // _getIconForIndex(index),
                          _getIconForIndex(title),
                          color: AllColors.whiteColor,
                        ),
                        title: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: AllColors.whiteColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO : implement initState  ......

    getMenuList();
    print("NAme.......${email}");
    //MrDrawer();
  }

  Future<void> getMenuList() async {
    name = await sessionManagement.getName() ?? '';
    email = await sessionManagement.getEmail() ?? '';

    IsCRM= int.parse( await sessionManagement.getIsCrm() ?? '0');
    await sessionManagement.getMenuList().then((menuList) {
      // Use setState to update the UI with the fetched menu list
      setState(() {
        globalMenuList = menuList;
      });
    });
  }

  IconData _getIconForIndex(String  Title) {
    switch (Title) {
      case "Services":
        return Icons.miscellaneous_services_outlined; // Change this icon as per your requirement
      case "Order":
        return Icons.shop; // Change this icon as per your requirement
      case "TA/DA":
        return Icons.car_crash_outlined;
      case "Approvals":
        return Icons.approval_outlined;
      case "Customers":
        return Icons.perm_contact_cal_outlined;
      case "My Work":
        return Icons.work_history_outlined;
      case "Sales":
        return Icons.save_as;
        // Add more cases for different indices if needed
      default:
        return Icons.exit_to_app; // Default icon
    }
  }
  bindprofileMenu() {
    return PopupMenuButton<String>(
      offset: Offset(0, 30),
      onSelected: (value) {
        if (value == 'Logout') {

          if(IsCRM==1){
            ConfirmationDialog(context);
          }else{
            Get.defaultDialog(
              title: "LogOut",
              titleStyle: const TextStyle(
                  color: AllColors.primaryDark1, fontSize: 18, fontWeight: FontWeight.bold),
              content: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text("Do you want to Logout?",
                  style: TextStyle(color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w600,fontSize: AllFontSize.fourtine),),
              ),
              confirm: OutlinedButton(
                  onPressed:() {
                    home_vm.logOut();
                    crmDatabase.deleteMyLocalDatabase();
                  },

                  child: const Text("Yes",
                style: TextStyle(color: AllColors.primaryDark1),)

              ),
              cancel: OutlinedButton(onPressed: () => Get.back(),
                child: const Text("No", style: TextStyle(color: Colors.red)),),
            );
          }
        }else if(value=="Profile"){
          Get.toNamed(RoutesName.profile_screen);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Profile',
          child: Text('Profile'),
        ),
        /*const PopupMenuItem<String>(
          value: 'item2',
          child: Text('Item 2'),
        ),*/
        const PopupMenuItem<String>(
          value: 'Logout',
          child: Text('Logout'),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          backgroundColor: AllColors.primaryDark1,
          child: Icon(Icons.person_pin, size: 25, color: Colors.white),
        ),
      ),
    );
  }




  ConfirmationDialog(context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: AllColors.lightredColor,),
                SizedBox(width: 5,),
                Text(
                    'Logout!',
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
                          'Do you want to logout?',
                          style: GoogleFonts.poppins(
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w500,
                            color: AllColors.primaryDark1,
                          )),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
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
                            onPressed: ()  async {
                              home_vm.logOut();
                              await crmDatabase.deleteAllItems();
                            },
                            child: Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Text('Confirm',
                                /*accountMaster_page_controller.UploadImageType_controller.value =="Url"? 'Upload Url':'Choose files',*/
                                style: GoogleFonts.poppins(
                                  color: AllColors.blackColor,
                                  fontSize: AllFontSize.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ]),
          );

        });
  }


}
