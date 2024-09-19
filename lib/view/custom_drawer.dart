import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';


import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';
import '../constants/static_methods.dart';
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
              height: size.height * .41 ,
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
                            margin: EdgeInsets.only(top: 8.0),
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
                                  height: 10.0,
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
               // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                    child: ListTile(
                                      onTap: () {
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
                onPressed: () => home_vm.logOut(), child: const Text("Yes",
              style: TextStyle(color: AllColors.primaryDark1),)

            ),
            cancel: OutlinedButton(onPressed: () => Get.back(),
              child: const Text("No", style: TextStyle(color: Colors.red)),),
          );
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




}
