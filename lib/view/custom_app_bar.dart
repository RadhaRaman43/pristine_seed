import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/app_colors.dart';
import '../constants/app_font_size.dart';
import '../viewModel/home_vm/HomeViewModel.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  CustomAppBar({
    Key? key,
    required  this.text,
  }) : super(key: key);
  final String? text;


 final home_vm = Get.put(HomeViewModel());
 Size size = Get.size;
 @override
 Widget build(BuildContext context) {
   return AppBar(
     title: Text(text ?? ""),
     iconTheme: IconThemeData(color: AllColors.primaryDark1),
     actions: [
       Padding(
         padding: const EdgeInsets.only(right: 18),
         child: InkWell(
             onTap: () {
               Get.defaultDialog(
                 title: "LOGOUT",
                 titleStyle: const TextStyle(
                     color: AllColors.primaryDark1,
                     fontSize: 18,
                     fontWeight: FontWeight.bold),
                 content: const Padding(
                   padding: EdgeInsets.symmetric(vertical: 15.0),
                   child: Text(
                     "Do you want to Logout?",
                     style: TextStyle(
                         color: AllColors.primaryDark1,
                         fontWeight: FontWeight.w600,
                         fontSize: AllFontSize.fourtine),
                   ),
                 ),
                 confirm: OutlinedButton(
                   onPressed: () => home_vm.logOut(),
                   child: const Text("Yes",
                       style: TextStyle(color: Colors.red)),
                 ),
                 cancel: OutlinedButton(
                     onPressed: () => Get.back(),
                     child: const Text(
                       "No",
                       style: TextStyle(color: AllColors.primaryDark1),
                     )),
               );

               // home_vm.logOut();
             },
             child: Icon(Icons.power_settings_new,
                 color: AllColors.whiteColor)),
       )
     ],
     //  title: Text("Home"),
     backgroundColor: AllColors.primaryDark,
   );



 }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

 /* @override
  State<CustomAppBar> createState() =>_AppBar();*/
}

/*
class _AppBar extends State<CustomAppBar>{

  final home_vm = Get.put(HomeViewModel());
  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
    return AppBar(

        iconTheme: IconThemeData(color: AllColors.primaryDark1),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: InkWell(
                onTap: () {
                  Get.defaultDialog(
                    title: "LOGOUT",
                    titleStyle: const TextStyle(
                        color: AllColors.primaryDark1,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        "Do you want to Logout?",
                        style: TextStyle(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w600,
                            fontSize: AllFontSize.fourtine),
                      ),
                    ),
                    confirm: OutlinedButton(
                      onPressed: () => home_vm.logOut(),
                      child: const Text("Yes",
                          style: TextStyle(color: Colors.red)),
                    ),
                    cancel: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "No",
                          style: TextStyle(color: AllColors.primaryDark1),
                        )),
                  );

                  // home_vm.logOut();
                },
                child: Icon(Icons.power_settings_new,
                    color: AllColors.whiteColor)),
          )
        ],
        //  title: Text("Home"),
        backgroundColor: AllColors.primaryDark,
      );



  }
*/



