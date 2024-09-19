
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:navigation_drawer_flutter/viewModel/SessionManagment/session_managment.dart';

import '../viewModel/service_managment_vm_directory/dashboard_vm/dashboard_vm.dart';


class StaticMethod{


  static String? convertDateFormat(String inputDate) {
    final inputFormat = DateFormat('dd-MM-yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
  }
  static String? convertDateFormat1(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd-MM-yyyy');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
  }

  static String? dateTimeToDate(String inputDate){
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('dd-MM-yyyy hh:mm aa');
    try {
      final date = inputFormat.parse(inputDate);
      print(outputFormat.format(date));
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
    // try{
    //   List<String> dateTimeParts = dateTime.split("T");
    //   print(dateTimeParts);
    //   String date = dateTimeParts[0];
    //   String time = dateTimeParts[1];
    //   List<String> timeParts = time.split('.');
    //   String fomatedTime = timeParts[0];
    //   DateTime parsedDate1 = DateTime.parse(date);
    //   String formattedDate1 = DateFormat('dd-MM-yyyy').format(parsedDate1);
    //   return formattedDate1;
    // }catch(e){
    //
    // }

  }
  static String? onlyDate(String inputDate){
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('dd-MM-yyyy');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }

  }



  static String? onlyTime(String inputDate){
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    final outputFormat = DateFormat('hh:mm aa');
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return inputDate; // Handle the error as needed
    }
  }





  static String? onlyMonthName(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('d MMMM');  // Format to get only the month name and day
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return null; // Return null or handle the error as needed
    }
  }


  static String? onlyMonthNameThreeCharacter(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('d MMM');  // Format to get only the 3-letter month name
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return null; // Return null or handle the error as needed
    }
  }


  static String? onlyYearName(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    //final outputFormat = DateFormat('d MMMM');  // Format to get only the month name and day
    final outputFormat = DateFormat('yyyy');  // Format to get only the month name and day
    try {
      final date = inputFormat.parse(inputDate);
      return outputFormat.format(date);
    } catch (e) {
      print("Error parsing date: $e");
      return null; // Return null or handle the error as needed
    }
  }



  /*static Future<void> strintToDecadeBase64()async{
    //todo stop background service

    try{
      return base64.decode(inspectinDetailPageController
          .online_offline_selected_inspection
          .value
          .fields![position]
          .fieldValue!);
    }catch(e){

    }

  }*/
  static Uint8List stringToDecodeBase64(String? base64String) {
    try {
      return base64.decode(base64String!);
    } catch (e) {
      return new Uint8List(0);
    }
  }

  static Future<String> getCurrentData()async{
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  static IconData getChildIconForIndex(String  cTitle) {
    switch (cTitle) {
      case 'Installation Request':
        return Icons
            .install_desktop_outlined;
        break;
    // Change this icon as per your requirement
      case "Order List":
        return Icons.shopping_cart;


      case "Corrective Request":
        return Icons.change_circle_outlined; // Change this icon as per your requirement
      case "Preventive Request":
        return Icons.sd_card_alert_rounded;
      case "Customer Complain":
        return Icons.person_pin_sharp;
      case "Return Indent":
        return Icons.format_indent_decrease_outlined;

      case "Indent List":
        return Icons.list_alt;

      case "Check In/Out":
        return Icons.location_on_sharp;

      case "User Route":
        return Icons.route;


      case "User Expense":
        return Icons.explicit_outlined;


      case "User Route":
        return Icons.route;


      case "Check In":
        return Icons.my_location;


      case "Expense":
        return Icons.explicit;

      case "Orders Approval":
        return Icons.approval_rounded;










    // Add more cases for different indices if needed
      default:
        return Icons.exit_to_app; // Default icon
    }
  }

  static Future<void> stopBackgroundService()async{
    //todo stop background service
    if (DashBoardViewModel.backgroundService != null){
      DashBoardViewModel.backgroundService!.getServiceInstance()!.invoke('stopService');
      DashBoardViewModel.backgroundService!.setServiceInstance(null);
      DashBoardViewModel.backgroundService = null;
    }
  }






}