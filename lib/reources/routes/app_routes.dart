import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/Contact_master_View/Contact_master_View/all_contact_master_screen.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/Task_Master_view/Task_Approval_List_Screen.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/Task_Master_view/task_master_approval_details.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/employee_information_system/emp_mark_leave_add_screen.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/sales_advise_view/sales_advise_header_line_screen.dart';
import 'package:navigation_drawer_flutter/CRM_Directory/CRM_View/sales_advise_view/sales_advise_header_screen.dart';
import 'package:navigation_drawer_flutter/component/error_404.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/check_in_approval/check_in_approval_screen.dart';
import 'package:navigation_drawer_flutter/view/forget_password/forget_password_screen.dart';
import 'package:navigation_drawer_flutter/view/home_view/home_screen.dart';
import 'package:navigation_drawer_flutter/view/notification_view/notification_screen.dart';
import 'package:navigation_drawer_flutter/view/show_route/show_route.dart';
import 'package:navigation_drawer_flutter/view/splash_view/splash_screen.dart';
import 'package:navigation_drawer_flutter/view/user_expense/create_expense_screen.dart';
import 'package:navigation_drawer_flutter/view/user_expense/expense_approver_screen.dart';
import 'package:navigation_drawer_flutter/view/user_expense/expense_screen.dart';
import 'package:navigation_drawer_flutter/view/user_expense/my_expense_screen.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/AccountDashBoardDataSales_Screen.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/AccountDashboardCount_Screen.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/AccountDashboardDataQuotation_Screen.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/AccountDashboardDataTask_Screen.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/AccountMaster_screen.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/Add_new_Account_master.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/Draft_item_list.dart';
import '../../CRM_Directory/CRM_View/Account_Master_view/update_account_master.dart';
import '../../CRM_Directory/CRM_View/Address_Master_view/Add_New_ConsigneeAdd.dart';
import '../../CRM_Directory/CRM_View/Address_Master_view/View_address_screen.dart';
import '../../CRM_Directory/CRM_View/All_Quote_Line_Item_View/All_Quote_Line_Item_Screen.dart';
import '../../CRM_Directory/CRM_View/All_Quote_view/All_Quote_Screen.dart';
import '../../CRM_Directory/CRM_View/Bussiness_Tour_Plan/Add_Tour_Lines_page.dart';
import '../../CRM_Directory/CRM_View/Bussiness_Tour_Plan/BusinessTourApprovalListScreen.dart';
import '../../CRM_Directory/CRM_View/Bussiness_Tour_Plan/BusinessTourPlanDetails_Screen.dart';
import '../../CRM_Directory/CRM_View/Bussiness_Tour_Plan/bussiness_tour_approve_rejected.dart';
import '../../CRM_Directory/CRM_View/Bussiness_Tour_Plan/bussiness_tour_plan_screen.dart';
import '../../CRM_Directory/CRM_View/Call_Dashboard_view/call_Dashboard_View_Screen.dart';
import '../../CRM_Directory/CRM_View/Call_Dashboard_view/commit_dashboard_viewScreen.dart';
import '../../CRM_Directory/CRM_View/Call_Dashboard_view/funnel_Dashboard_view.dart';
import '../../CRM_Directory/CRM_View/Call_Dashboard_view/sales_Dashboard_ViewScreen.dart';
import '../../CRM_Directory/CRM_View/Contact_master_View/Contact_master_View/Add_newContact_Master.dart';
import '../../CRM_Directory/CRM_View/Contact_master_View/Contact_master_View/Contact_Master_Screen.dart';
import '../../CRM_Directory/CRM_View/Contact_master_View/Contact_master_View/View_contacts_screen.dart';
import '../../CRM_Directory/CRM_View/Pending_Draft_Quote_view/pending_Draft_Quote.dart';
import '../../CRM_Directory/CRM_View/Task_Master_view/Add_new_DSAR_screen.dart';
import '../../CRM_Directory/CRM_View/Task_Master_view/Add_new_Task_Screen.dart';
import '../../CRM_Directory/CRM_View/Task_Master_view/Task_Master_Details.dart';
import '../../CRM_Directory/CRM_View/Task_Master_view/Task_master_screen.dart';
import '../../CRM_Directory/CRM_View/Task_Master_view/update_task_mst_infra_screen.dart';
import '../../CRM_Directory/CRM_View/employee_information_system/emp_mark_leave_screen.dart';
import '../../CRM_Directory/CRM_View/quote_approval_list/quote_approval_list_screen.dart';
import '../../CRM_Directory/CRM_View/sales_advise_view/sales_advise_create_screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/ItemListBySalesCycle_Screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/approval_person_list.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/approved_quotation_list.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/quote_approve_reject_screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/quote_item_list.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/sale_cycle_pending_for_approval_list.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/sales_cycle_create_quote_screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/sales_cycle_quote_information_screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/sales_cycle_screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/update_bussiness_term_page.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/update_quote_line_data_screen.dart';
import '../../CRM_Directory/CRM_View/sales_cycle_view/view_sale_header_screen.dart';
import '../../view/check_in_approval/check_in_approval_header_view_screen.dart';
import '../../view/check_in_view/check_in_screen.dart';
import '../../view/check_out_view/add_expense_screen.dart';
import '../../view/check_out_view/check_out.dart';
import '../../view/login_view/login_screen.dart';
import '../../view/profile_view/profile_screen.dart';
import '../../view/service_managment_view_directory/bulk_indent_view/bulk_indent_screen.dart';
import '../../view/service_managment_view_directory/bulk_indent_view/create_bulk_indent_screen.dart';
import '../../view/service_managment_view_directory/corrective_view/corrective_indent_header_view_screen.dart';
import '../../view/service_managment_view_directory/corrective_view/corrective_mark_visit_screen.dart';
import '../../view/service_managment_view_directory/corrective_view/corrective_screen.dart';
import '../../view/service_managment_view_directory/corrective_view/corrective_view_details_screen.dart';
import '../../view/service_managment_view_directory/customer_complain/complain_customer_page.dart';
import '../../view/service_managment_view_directory/customer_complain/customer_complain_screen.dart';
import '../../view/service_managment_view_directory/indent_list/indent_header_details_screen.dart';
import '../../view/service_managment_view_directory/indent_list/indent_list.dart';
import '../../view/service_managment_view_directory/installation_view/indent_header_view_screen.dart';
import '../../view/service_managment_view_directory/installation_view/installation_screen.dart';
import '../../view/service_managment_view_directory/installation_view/installation_view_details_screen.dart';
import '../../view/service_managment_view_directory/installation_view/mark_visit_screen.dart';
import '../../view/service_managment_view_directory/order_view/approval_view_cart.dart';
import '../../view/service_managment_view_directory/order_view/new_order_screen.dart';
import '../../view/service_managment_view_directory/order_view/order_approval_screen.dart';
import '../../view/service_managment_view_directory/order_view/order_item_category_screen.dart';
import '../../view/service_managment_view_directory/order_view/order_item_veriety_screen.dart';
import '../../view/service_managment_view_directory/order_view/order_screen.dart';
import '../../view/service_managment_view_directory/order_view/view_cart_screen.dart';
import '../../view/service_managment_view_directory/preventive_view/CreatePreventiveCalenderScreen.dart';
import '../../view/service_managment_view_directory/preventive_view/preventive_indent_header_view_screen.dart';
import '../../view/service_managment_view_directory/preventive_view/preventive_mark_visit.dart';
import '../../view/service_managment_view_directory/preventive_view/preventive_screen.dart';
import '../../view/service_managment_view_directory/preventive_view/preventive_view_detail_screen.dart';
import '../../view/service_managment_view_directory/return_indent/new_return_indent.dart';
import '../../view/service_managment_view_directory/return_indent/return_header_details_view_screen.dart';
import '../../view/service_managment_view_directory/return_indent/return_indent_screen.dart';
import '../../view/service_managment_view_directory/return_indent/return_ndent_add_line.dart';
import '../../view/service_managment_view_directory/service_inventory/service_inventory_screen.dart';
import '../../view/service_managment_view_directory/service_inventory/service_inventory_view_details_screen.dart';
import '../../view/user_expense/expense_approver_header_view_screen.dart';

class AppRoutes{
  static appRoutes()=>[
    GetPage(name: RoutesName.splashscreen,
        page: ()=>SplashScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.loginScreen,
        page: ()=>LoginScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.homeScreen,
        page: ()=>HomeScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.profile_screen,
        page: ()=>ProfileScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.forgetScreen,
        page: ()=>ForgetPasswordScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.installation_screen,
        page: ()=>InstallationScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.installation_details_screen,
        page: ()=>InstallationViewDetailsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.installation_mark_visit,
        page: ()=>MarkVisit(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.installation_Indent_view,
        page: ()=>IndentHeaderViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    //todo Corrective Screen....

    GetPage(name: RoutesName.corrective_screen,
        page: ()=>CorrectiveScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.corrective_details_screen,
        page: ()=>CorrectiveViewDetailsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.corrective_markvisit_screen,
        page: ()=>CorrectiveMarkVisitScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.corrective_indent_screen,
        page: ()=>CorrectiveIndentHeaderViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    //todo preventive Screen......

    GetPage(name: RoutesName.preventive_screen,
        page: ()=>PreventiveScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.preventive_details_screen,
        page: ()=>PreventiveViewDetailScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.preventive_markvisit_screen,
        page: ()=>PreventiveMarkVisitScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),



    GetPage(name: RoutesName.preventive_Indent_header_view_screen,
        page: ()=>PreventiveIndentHeaderViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.create_preventive_calender_view_screen,
        page: ()=>CreatePreventiveCalenderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.notofication_screen,
        page: ()=>NotificationScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.notofication_screen,
        page: ()=>NotificationScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.checkIn_screen,
        page: ()=>CheckInScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.checkout_screen,
        page: ()=>CheckOutScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.addExpanseScreen,
        page: ()=>AddExpanseScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.checkInApproval,
        page: ()=>CheckInApprovalScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.checkInApprovalHeaderView,
        page: ()=>CheckInApprovalHeaderViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.myExpenseScreen,
        page: ()=>MyExpenseScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.expenseScreen,
        page: ()=>ExpensesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.createExpenseScreen,
        page: ()=>CreateExpenseScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.expenseApprovarScreen,
        page: ()=>ExpenseApprovarScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.expenseApprovarHeaderScreen,
        page: ()=>ExpenseApproverHeaderViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.showRouteScreen,
        page: ()=>ShowRoutesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    //todo return indent.....

    GetPage(name: RoutesName.newReturnIndentScreen,
        page: ()=>NewReturnIndentScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.returnHeaderDetailsScreen,
        page: ()=>ReturnHeaderDetailsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.returnIndentScreen,
        page: ()=>ReturnIndentScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),



    GetPage(name: RoutesName.returnIndentAddLineScreen,
        page: ()=>ReturnIndentAddLine(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    //todo order screen....

    GetPage(name: RoutesName.order_screen,
        page: ()=>OrderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.order_item_category_screen,
        page: ()=>OrderItemCategoryScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.order_view_cart_screen,
        page: ()=>ViewCartScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.order_variety_screen,
        page: ()=>OrderItemVarietyScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.new_order_screen,
        page: ()=>NewOrderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.order_approval_screen,
        page: ()=>OrderApprovalScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.order_approval_view_cart_screen,
        page: ()=>ApprovalViewCart(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.indentListscreen,
        page: ()=>IndentListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.indentListDetailsscreen,
        page: ()=>IndentHeaderDetailsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),



    //todo Customer Complain Screen
    GetPage(name: RoutesName.customer_complain_screen,
        page: ()=>CustomerComplainScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.complain_customer_page,
        page: ()=>ComplainCustomerPage(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

   //todo create bulk indent.......

    GetPage(name: RoutesName.bulk_indent_screen,
        page: ()=>BulkIndentListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


     GetPage(name: RoutesName.create_bulk_indent_screen,
        page: ()=>CreateBulkIndentScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
     ),

    GetPage(name: RoutesName.service_inventory_screen,
        page: ()=>ServiceInventoryListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.service_inventory_view_screen,
        page: ()=>ServiceInventoryViewDetailsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


//todo crm routes...


    //todo Account Master Screen....
    GetPage(name: RoutesName.accountMaster_screen,
        page: ()=>AccountmasterScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.add_New_AccountMaster_screen,
        page: ()=>AddNewAccountMaster(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.update_AccountMaster_screen,
        page: ()=>UpdateAccountMaster(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.Draft_item_list,
        page: ()=>DraftItemList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    //todo Task Master Screen....
    GetPage(name: RoutesName.taskMaster_screen,
        page: ()=>TaskMasterScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.taskApproval_List,
        page: ()=>TaskApprovalListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.addNewTaskMaster_screen,
        page: ()=>AddNewTaskScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.addNewDSARTask_screen,
        page: ()=>AddNewDsarScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.taslMasterApprovalDetailsScreen,
        page: ()=>TaskMasterApprovalDetails(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.taskMasterDetails_screen,
        page: ()=>TaskMasterDetails(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    //todo Contact master Screen
    GetPage(name: RoutesName.contactMaster_screen,
        page: ()=>ContactMasterScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),



    GetPage(name: RoutesName.allContactMasterScreen,
        page: ()=>AllContactMasterScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.addNewContactMaster_screen,
        page: ()=>AddNewcontactMasterContact(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.viewContacts_screen,
        page: ()=>ViewContactsScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.viewAddress_screen,
        page: ()=>ViewAddressScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.addNewAddress_screen,
        page: ()=>AddNewConsigneeadd(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.AccountDashboardCount_Screen,
        page: ()=>AccountdashboardcountScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.AccountDashboardData_Screen,
        page: ()=>AccountdashboarddatalistScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.AccountDashboardDataSales_Screen,
        page: ()=>AccountdashboarddatasalesScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.AccountDashboardDataQuotation_Screen,
        page: ()=>AccountdashboarddataquotationScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

//todo Sale Cycle Screen
    GetPage(name: RoutesName.salesCycleScreen,
        page: ()=>SalesCycleScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.viewSalesCycleHeaderScreen,
        page: ()=>ViewSaleHeaderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.salesCycleCreateQuoteScreen,
        page: ()=>SalesCycleCreateQuoteScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.quoteInformationScreen,
        page: ()=>QuoteInformationScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.quoteItemList,
        page: ()=>QuoteItemList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.ItemListBySalesCycle_Screen,
        page: ()=>Itemlist_by_sales_cycle_Screen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.updatequoteLineData,
        page: ()=>UpdateQuoteLineDataScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.approvalPersonList,
        page: ()=>ApprovalPersonList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.UpdateBussinessTermPage,
        page: ()=>UpdateBussinessTermPage(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.updateTaskMstInfraScreen,
        page: ()=>UpdateTaskMstInfraScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.quoteApprovalListScreen,
        page: ()=>QuoteApprovalListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.approvedQuotationListScreen,
        page: ()=>ApprovedQuotationList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.salesAdviseCreateScreen,
        page: ()=>SalesAdviseCreateScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.salesAdviseHeaderScreen,
        page: ()=>SalesAdviseHeaderScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.salesAdviseHeaderLineScreen,
        page: ()=>SalesAdviseHeaderLineScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.empMarkLeaveScreen,
        page: ()=>EmpMarkLeaveScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.empMarkLeaveAddScreen,
        page: ()=>EmpMarkLeaveAddScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.salesCyclePendingForApprovalListScreen,
        page: ()=>SaleCyclePendingForApprovalList(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),
    GetPage(name: RoutesName.pendingDraftQuoteScreen,
        page: ()=>PendingDraftQuote(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.approvedRejectedQuoteScreen,
        page: ()=>QuoteApproveRejectScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.allQuoteScreenScreen,
        page: ()=>AllQuoteScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.allQuoteLineItemScreen,
        page: ()=>AllQuoteLineItemScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.BusinessTourPlanScreen,
        page: ()=>BussinessTourPlanScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.BusinessTourPlanDetails,
        page: ()=>BusinessTourPlanDeatil(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.AddTourLinesPage,
        page: ()=>AddTourLinesPage(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.BusinessTourApprovalListScreen,
        page: ()=>BusinessTourApprovalListScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.BusinessTourApproveRejectListScreen,
        page: ()=>BussinessTourApproveRejected(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: RoutesName.callDashboardViewScreen,
        page: ()=>CallDashboardViewScreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.funnelDashboardViewScreen,
        page: ()=>FunnelDashboardView(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.commitDashboardViewScreen,
        page: ()=>CommitDashboardViewscreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: RoutesName.salesDashboardViewScreen,
        page: ()=>SalesDashboardViewscreen(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),




//todo image not found....




    GetPage(name: RoutesName.image_not_found_screen,
        page: ()=>ImageNotFound(),
        transitionDuration: Duration(microseconds: 180),
        transition: Transition.rightToLeftWithFade
    ),






  ];
}