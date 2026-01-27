import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateQuoteHeaderScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {


        return false;
      },
      child: Scaffold(

      )
    );
  }

}