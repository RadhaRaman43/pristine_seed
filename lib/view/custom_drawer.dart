import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/Dashboard_VM/commit_dashboard_vm.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/Task_master_vm/Task_ApprovalVM.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/emp_infor_system/emp_mark_leave_request_vm.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_pending_for_approval_vm.dart';



import '../CRM_Directory/CRM_VIewModels/Bussiness_Tour_Plan_Vm/BusinessPlanTour_Vm.dart';
import '../CRM_Directory/CRM_VIewModels/Bussiness_Tour_Plan_Vm/Business_Tour_Approval_Vm.dart';
import '../CRM_Directory/CRM_VIewModels/Dashboard_VM/Pending_DSAR_Dashboard_VM.dart';
import '../CRM_Directory/CRM_VIewModels/Dashboard_VM/Sales_Dashboard_Vm.dart';
import '../CRM_Directory/CRM_VIewModels/Dashboard_VM/call_dashboard_vm.dart';
import '../CRM_Directory/CRM_VIewModels/Dashboard_VM/funnel_dashboard_Vm.dart';
import '../CRM_Directory/CRM_VIewModels/Task_master_vm/TaskMasterVM.dart';
import '../CRM_Directory/CRM_VIewModels/account_master_vm/accountMasterVM.dart';
import '../CRM_Directory/CRM_VIewModels/contact_master_vm/contact_master_vm/ContactMasterVM.dart';
import '../CRM_Directory/CRM_VIewModels/contact_master_vm/contact_master_vm/all_contact_master_vm.dart';
import '../CRM_Directory/CRM_VIewModels/emp_infor_system/leave_request_approval_vm.dart';
import '../CRM_Directory/CRM_VIewModels/item_master_vm/item_mater_vm.dart';
import '../CRM_Directory/CRM_VIewModels/quote_approval_list_vm/quote_approval_list_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/pending_Draft_Quote_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_advise_all_list_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_competitor_product_infor_vm.dart';
import '../CRM_Directory/CRM_VIewModels/sales_cycle_vm/sales_cycle_vm.dart';
import '../CRM_Directory/CRM_VIewModels/salesforecasrVM/SalesForeCastVM.dart';
import '../CRM_Directory/CRM_VIewModels/salesforecasrVM/rolling_forecast_cbh_vm.dart';
import '../CRM_Directory/CRM_VIewModels/salesforecasrVM/rolling_forecast_gm_vm.dart';
import '../CRM_Directory/CRM_VIewModels/salesforecasrVM/rolling_forecast_logistic_vm.dart';
import '../CRM_Directory/CRM_VIewModels/salesforecasrVM/rolling_forecast_rh_vm.dart';
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
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: 330,
                height: size.height * .35 ,
                decoration: BoxDecoration(
                  color: AllColors.primaryDark1,
                ),
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
                                      child: dashBoard_vm.imageUrl.isNotEmpty?Image.network(dashBoard_vm.imageUrl.toString(),width: 90,
                                        height: 90,  fit: BoxFit.cover,):Image.asset("assests/images/no_file.png",fit: BoxFit.cover),
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
                                    child: Tooltip(
                                      message: email,
                                      child: Text(
                                        email,
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600,
                                            color: AllColors.whiteColor),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
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
                                                sessionManagement.setfilterRouting('Check In/Out');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.toNamed(RoutesName.checkIn_screen,preventDuplicates: false);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Check In':
                                                sessionManagement.setfilterRouting('Check In');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.toNamed(RoutesName.checkInApproval,preventDuplicates: false);
                                                Navigator.of(context);
                                                break;
          
                                              case 'User Expense':
                                                sessionManagement.setfilterRouting('User Expense');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.toNamed(RoutesName.myExpenseScreen,preventDuplicates: false);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Expense':
                                                sessionManagement.setfilterRouting('Expense');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.toNamed(RoutesName.expenseApprovarScreen,preventDuplicates: false);
                                                Navigator.of(context);
                                                break;
          
          
                                              case 'User Route':
                                                sessionManagement.setfilterRouting('User Route');
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
                                                sessionManagement.setfilterRouting('User Inventory');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.toNamed(RoutesName.service_inventory_screen,preventDuplicates: false);
                                                Navigator.of(context);
                                                break;
          
          
                                            //todo crm routing.....

                                              case 'Accounts Master':
                                                sessionManagement.setfilterRouting('Accounts Master');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<Accountmastervm>();
                                                Get.toNamed(RoutesName.accountMaster_screen,);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Contacts Master':
                                                sessionManagement.setfilterRouting('Contacts Master');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<ContactMasterVM>();
                                                Get.toNamed(RoutesName.contactMaster_screen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Account Draft':
                                                sessionManagement.setfilterRouting('Account Draft');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<Accountmastervm>();
                                                Get.toNamed(RoutesName.Draft_item_list);
                                                Navigator.of(context);
                                                break;
          
                                              case 'All Contacts Master':
                                                sessionManagement.setfilterRouting('All Contacts Master');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<AllContactMasterVm>();
                                                Get.toNamed(RoutesName.allContactMasterScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Tasks':
                                                sessionManagement.setfilterRouting('Tasks');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<Taskmastervm>();
                                                Get.toNamed(RoutesName.taskMaster_screen);
                                                Navigator.of(context);
                                                break;
                                              case 'Task Approval List':
                                                sessionManagement.setfilterRouting('Task Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<TaskApprovalvm>();
                                                Get.toNamed(RoutesName.taskApproval_List);
                                                Navigator.of(context);
                                                break;
                                              case 'Sales Cycle':
                                                sessionManagement.setfilterRouting('Sales Cycle');
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
                                                sessionManagement.setfilterRouting('Quote Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<QuoteApprovalListVm>();
                                                Get.toNamed(RoutesName.quoteApprovalListScreen,);
                                                Navigator.of(context);
                                                break;

                                              case 'Quote RH Approval List':
                                                sessionManagement.setfilterRouting('Quote RH Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<QuoteApprovalListVm>();
                                                Get.toNamed(RoutesName.quoteRHApprovalListScreen,);
                                                Navigator.of(context);
                                                break;
                                              case 'Quote CBH Approval List':
                                                sessionManagement.setfilterRouting('Quote CBH Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<QuoteApprovalListVm>();
                                                Get.toNamed(RoutesName.quoteCBHApprovalListScreen,);
                                                Navigator.of(context);
                                                break;
                                              case 'Quote GM Approval List':
                                                sessionManagement.setfilterRouting('Quote GM Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<QuoteApprovalListVm>();
                                                Get.toNamed(RoutesName.quoteGMApprovalListScreen,);
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
                                                sessionManagement.setfilterRouting('Mark Leave Request');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<EmpMarkLeaveRequestVm>();
                                                EmpMarkLeaveRequestVm employeeMarkLeaveController=Get.put(EmpMarkLeaveRequestVm());
                                                Get.toNamed(RoutesName.empMarkLeaveRequestScreen,);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Leave Request Approval':
                                                sessionManagement.setfilterRouting('Leave Request Approval');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<LeaveRequestApprovalVm>();
                                                LeaveRequestApprovalVm employeeMarkLeaveController=Get.put(LeaveRequestApprovalVm());
                                                Get.toNamed(RoutesName.empMarkLeaveRequestApprovalScreen,);
                                                Navigator.of(context);
                                                break;
          
          
                                              case 'Sales Cycle Approval List':
                                                sessionManagement.setfilterRouting('Sales Cycle Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<SalesCyclePendingForApprovalVm>();
                                                SalesCyclePendingForApprovalVm employeeMarkLeaveController=Get.put(SalesCyclePendingForApprovalVm());
                                                //employeeMarkLeaveController.getsalesCycleData(employeeMarkLeaveController.pageNumber,);
                                                Get.toNamed(RoutesName.salesCyclePendingForApprovalListScreen,);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Pending Draft Quote':
                                                sessionManagement.setfilterRouting('Pending Draft Quote');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<PendingDraftQuoteVm>();
                                                Get.toNamed(RoutesName.pendingDraftQuoteScreen,arguments: 'Pending Draft Quote');
                                                Navigator.of(context);
                                                break;
          
                                              case 'Approved / Rejected Quote':
                                                sessionManagement.setfilterRouting('Approved / Rejected Quote');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<PendingDraftQuoteVm>();
                                                Get.toNamed(RoutesName.approvedRejectedQuoteScreen,arguments: 'Approved / Rejected Quote');
                                                Navigator.of(context);
                                                break;
          
                                              case 'All SPR Mapping Line Items':
                                                sessionManagement.setfilterRouting('All SPR Mapping Line Items');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<PendingDraftQuoteVm>();
                                                Get.toNamed(RoutesName.allSPRMappingScreen,arguments: 'All SPR Mapping Line Items');
                                                Navigator.of(context);
                                                break;
          
                                              case 'Sales Cycle Competitor List':
                                                sessionManagement.setfilterRouting('Sales Cycle Competitor List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<SalesCycleCompetitorProductInforVm>();
                                                SalesCycleCompetitorProductInforVm PendingDraftQuoteController=Get.put(SalesCycleCompetitorProductInforVm());
                                                Get.toNamed(RoutesName.salesCycleCompetitorProductInforScreen,);
                                                Navigator.of(context);
                                                break;
          
          
                                              case 'All Quote':
                                                sessionManagement.setfilterRouting('All Quote');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<PendingDraftQuoteVm>();
                                                Get.toNamed(RoutesName.allQuoteScreenScreen,arguments: 'All Quote');
                                                Navigator.of(context);
                                                break;
          
                                              case 'All Quote Line Items':
                                                sessionManagement.setfilterRouting('All Quote Line Items');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<PendingDraftQuoteVm>();
                                                Get.toNamed(RoutesName.allQuoteLineItemScreen,arguments: 'All Quote Line Items');
                                                Navigator.of(context);
                                                break;
          
          
                                              case 'All Sales Advice List':
                                                sessionManagement.setfilterRouting('All Sales Advice List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<SalesAdviseAllListVm>();
                                                Get.toNamed(RoutesName.allSalesAdviseList,);
                                                Navigator.of(context);
                                                break;
          
                                              case 'All Sales Advice Line Items':
                                                sessionManagement.setfilterRouting('All Sales Advice Line Items');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<SalesAdviseAllListVm>();
                                                Get.toNamed(RoutesName.allSalesAdviseLineItemsScreen,);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Business Tour Plan':
                                                sessionManagement.setfilterRouting('Business Tour Plan');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<BusinessPlanTourViewModel>();
                                                BusinessPlanTourViewModel BusinessTourPlanController=Get.put(BusinessPlanTourViewModel());
                                                Get.toNamed(RoutesName.BusinessTourPlanScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Business Tour Plan Line Details':
                                                sessionManagement.setfilterRouting('Business Tour Plan Line Details');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<BusinessPlanTourViewModel>();
                                                BusinessPlanTourViewModel BusinessTourPlanLineDetailsController=Get.put(BusinessPlanTourViewModel());
                                                Get.toNamed(RoutesName.BusinessTourPlanLineDetailScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Business Tour Approval List':
                                                sessionManagement.setfilterRouting('Business Tour Approval List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<BusinessTourApprovalVm>();
                                                BusinessTourApprovalVm BusinessTourApprovalController=Get.put(BusinessTourApprovalVm());
                                                Get.toNamed(RoutesName.BusinessTourApprovalListScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Approved / Rejected Business Tour Plan':
                                                sessionManagement.setfilterRouting('Approved / Rejected Business Tour Plan');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<BusinessTourApprovalVm>();
                                                BusinessTourApprovalVm BusinessTourApprovalController=Get.put(BusinessTourApprovalVm());
                                                Get.toNamed(RoutesName.BusinessTourApproveRejectListScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Call Dashboard':
                                                sessionManagement.setfilterRouting('Call Dashboard');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<CallDashboardVm>();
                                                CallDashboardVm callDashboardController=Get.put(CallDashboardVm());
                                                Get.toNamed(RoutesName.callDashboardViewScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Funnel Dashboard':
                                                sessionManagement.setfilterRouting('Funnel Dashboard');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<FunnelDashboardVm>();
                                                FunnelDashboardVm callDashboardController=Get.put(FunnelDashboardVm());
                                                Get.toNamed(RoutesName.funnelDashboardViewScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Commit Dashboard':
                                                sessionManagement.setfilterRouting('Commit Dashboard');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<CommitDashboardVm>();
                                                CommitDashboardVm callDashboardController=Get.put(CommitDashboardVm());
                                                Get.toNamed(RoutesName.commitDashboardViewScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Sales Dashboard ':
                                                sessionManagement.setfilterRouting('Sales Dashboard');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<SalesDashboardVm>();
                                                SalesDashboardVm callDashboardController=Get.put(SalesDashboardVm());
                                                Get.toNamed(RoutesName.salesDashboardViewScreen);
                                                Navigator.of(context);
                                                break;
          
                                              case 'Pending DSAR Dashboard':
                                                sessionManagement.setfilterRouting('Pending DSAR Dashboard');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<PendingDsarDashboardVm>();
                                                Get.toNamed(RoutesName.pendingDSARDashboardViewScreen);
                                                Navigator.of(context);
                                                break;

                                              case 'Non Standard Items':
                                                sessionManagement.setfilterRouting('Non Standard Items');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<ItemMasterVm>();
                                                Get.toNamed(RoutesName.nonStandardItemList);
                                                Navigator.of(context);
                                                break;

                                              case 'Rolling Forecast List':
                                                sessionManagement.setfilterRouting('Rolling Forecast List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<SalesForeCastVM>();
                                                Get.toNamed(RoutesName.SalesForeCastScreen);
                                                Navigator.of(context);
                                                break;

                                              case 'Rolling Forecast RH List':
                                                sessionManagement.setfilterRouting('Rolling Forecast RH List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<RollingForeCastRHVM>();
                                                Get.toNamed(RoutesName.rollingForeCastRhListScreen);
                                                Navigator.of(context);
                                                break;

                                              case 'Rolling Forecast Logistic List':
                                                sessionManagement.setfilterRouting('Rolling Forecast Logistic List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<RollingForeCastLogisticVM>();
                                                Get.toNamed(RoutesName.rollingForeCastLogisticListScreen);
                                                Navigator.of(context);
                                                break;
                                              case 'Rolling Forecast CBH List':
                                                sessionManagement.setfilterRouting('Rolling Forecast CBH List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<RollingForeCastCBHVM>();
                                                Get.toNamed(RoutesName.rollingForeCastCBHListScreen);
                                                Navigator.of(context);
                                                break;
                                              case 'Rolling Forecast GM List':
                                                sessionManagement.setfilterRouting('Rolling Forecast GM List');
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.delete<RollingForeCastGmVM>();
                                                Get.toNamed(RoutesName.rollingForeCastGmListScreen);
                                                Navigator.of(context);
                                                break;



                                              default :
                                                IconData iconData = StaticMethod.getChildIconForIndex(cTitle);
                                                home_vm.openMenu(cTitle, iconData);
                                                Get.offAllNamed(RoutesName.pageNotFoundScreen, arguments: cTitle);
                                                Navigator.of(context);

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
