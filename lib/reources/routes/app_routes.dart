import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
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










  ];
}