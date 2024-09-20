import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_drawer_flutter/constants/app_colors.dart';
import 'package:navigation_drawer_flutter/reources/routes/routes_name.dart';
import 'package:navigation_drawer_flutter/view/login_view/login_screen.dart';
import 'package:navigation_drawer_flutter/viewModel/home_vm/HomeViewModel.dart';
import 'package:navigation_drawer_flutter/viewModel/notification_vm/notification_vm.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';
import 'package:stylish_bottom_bar/model/options.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import '../../CRM_Directory/CRM_View/DashboardCRM_Screen.dart';
import '../../constants/app_font_size.dart';
import '../../models/loginModel/login_model.dart';
import '../../viewModel/SessionManagment/session_managment.dart';
import '../custom_drawer.dart';
import '../profile_view/profile_screen.dart';
import '../search_view/search_view.dart';
import '../service_managment_view_directory/dashboard_view/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeStateScreen();
}

class _HomeStateScreen extends State<HomeScreen> {
  final home_vm = Get.put(HomeViewModel());
  final notification_page_controller = Get.put(NotificationViewModel());
  SessionManagement sessionManagement = SessionManagement();
  List<Menu> globalMenuList = [];
  List<Children> globalchildList = [];
  String name = '';
  String email = '';
  Size size = Get.size;
  PageController controller = PageController(initialPage: 0);
  var selected = 0;
  int IsCRM =0;

  @override
  void initState() {
    // TODO: implement initState
    getMenuList();
    print("NAme.......${name}");
    //MrDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              children: [
                IconButton(onPressed: () {
                  Get.toNamed(RoutesName.notofication_screen);
                }, icon: Icon(Icons.notifications)),
                Positioned(
                  top: 8,
                  right: 10,
                  child: Obx(
                    () {
                      return Visibility(
                        visible:notification_page_controller.totalUnacknowledgedCount>0?true:false ,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          height: 15,
                          width: 15,
                          child: Center(
                              child:
                              Obx(() {
                                  return Visibility(
                                    visible:notification_page_controller.totalUnacknowledgedCount>=0 ?true:false ,
                                    child: Text(notification_page_controller.totalUnacknowledgedCount.value.toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight:FontWeight.w700,
                                            fontSize: AllFontSize.twelve,
                                            color: AllColors.primaryDark1)
                                    ),
                                  );
                                },
                              )),
                        ),
                      );
                    },
                   // child:
                  ),
                )
              ],
            ),
          )

          //Icon(Icons.search),
          /*Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: () {
            }, icon: Icon(Icons.settings),),
          ),*/

        ],
        backgroundColor: AllColors.whiteColor,
      ),
      drawer: CustomDrawer(),
      // drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh:refreshData ,
        child: Scaffold(
            body:   IsCRM==0 ?DashBoard():DashboardcrmScreen()
            // body: isCrm==0?DashBoard():CrmDashBoard(),
          //body:DashBoard()

          /*PageView(
            controller: controller,
            children: [
              DashBoard(),
              ProfileScreen(),
              SearchScreen(),
            ],
          ),
          bottomNavigationBar: StylishBottomBar(
            option: BubbleBarOptions(
              // barStyle: BubbleBarStyle.vertical,
              barStyle: BubbleBarStyle.horizontal,
              bubbleFillStyle: BubbleFillStyle.fill,
              // bubbleFillStyle: BubbleFillStyle.outlined,
              opacity: 0.3,
            ),
            iconSpace: 12.0,
            items: [
              BottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                backgroundColor: AllColors.primaryDark1,

                // selectedColor: Colors.pink,
                selectedIcon: const Icon(Icons.home),
                //badge: const Text('1+'),
                //badgeColor: Colors.red,
                //showBadge: true,
              ),
              BottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text('Search'),
                selectedColor: AllColors.primaryDark1,
                backgroundColor: AllColors.primaryDark1,
              ),
              BottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                backgroundColor: AllColors.primaryDark1,
              ),
              */

          /* BottomBarItem(
                icon: const Icon(Icons.cabin),
                title: const Text('Cabin'),
                backgroundColor: Colors.purple,
              ),*/
          /*
            ],
            hasNotch: true,
            currentIndex: selected,
            onTap: (index) {
              setState(() {
                selected = index;
                controller.jumpToPage(index);
              });
            },
          ),*/
        ),
      ),
    );
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


  Future<void> refreshData() async {
    notification_page_controller.getNotificationList("get", "");
  }
}
