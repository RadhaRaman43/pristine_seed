import 'package:flutter/cupertino.dart';

class SalesForceCastScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: onWillPop,
      child: child, );
  }

}