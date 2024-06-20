import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation_drawer_flutter/view/splash_view/components/body.dart';

import '../../size_config.dart';
import '../../viewModel/services/splash_services.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SplashSecreenState();
}

class _SplashSecreenState extends State<SplashScreen>{
  SplashServices splashServices=SplashServices();

  @override
  void initState() {
    super.initState();
    //locationData.getCurrentPosition();
    //locationData.getCurrentLocation();//

    splashServices.isLogin();
    // splashServices.checkInternetAndRequest(context);.

  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body:Body()
    );
  }


}