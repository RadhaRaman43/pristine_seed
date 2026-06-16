import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../CRM_VIewModels/salesforecasrVM/rolling_forecast_logistic_vm.dart';


class RollingForeCastLogisticListScreen extends StatelessWidget{
  final rh_vm = Get.put(RollingForeCastLogisticVM());
  ScrollController scrollController = ScrollController();
  static String _displayStringTypeDropDownForOption(String option) =>
      option;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}