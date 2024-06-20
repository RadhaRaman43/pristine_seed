import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../reources/routes/routes_name.dart';
import '../../../viewModel/services/splash_services.dart';

class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  SplashServices splashServices = SplashServices();



  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> _animation;

  // Added to track whether images are loading
  late ImageProvider backgroundImage, logoImage;

  @override
  void didChangeDependencies() async {
   backgroundImage = AssetImage("assests/images/splash.png");
    logoImage = AssetImage("assests/images/pristine_pfulfill.png");
    logoImage = AssetImage("assests/images/pristine_pfulfill.png");
    await precacheImage(backgroundImage, context);
    await precacheImage(logoImage, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _enableRotation();
    super.dispose();
  }
/*  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust the duration as needed
    );

    _animation = Tween<double>(
      begin: 1.0, // Starting position (fully visible)
      end: 0.0, // Ending position (fully hidden)
    ).animate(_controller);

    _controller.forward(); // Start the animation
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20, // Adjust this as needed
              ),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(image: logoImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text(
                  "Welcome To Our Company!",
                  style: TextStyle(
                    fontSize:20,
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Powered By: Pristine Business Solutions",
                  style: TextStyle(
                    fontSize: 12,
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(RoutesName.loginScreen);
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize:20),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AllColors.whiteColor,
                    side: BorderSide(
                      width: 1.0,
                      color: Color.fromARGB(121, 22, 100, 33),
                    ),
                    backgroundColor: Color.fromARGB(121, 22, 60, 33),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

    /*Stack(
      children: [
        Positioned(
          top: 225,
          left: size * .100,
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration:
                    BoxDecoration(image: DecorationImage(image: logoImage)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Text("Welcome To Our Company!",
                    style: TextStyle(
                        fontSize: 20,
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text("Powered By: Pristine Business Solutions",
                    style: TextStyle(
                        fontSize: 12,
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500
                    )),
              ),

              Container(
                margin: EdgeInsets.only(top: size*.25),
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(RoutesName.loginScreen);
                  },
                  child: const Text('Get Started',style: TextStyle(fontSize: 20),),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AllColors.whiteColor, side: BorderSide(
                        width: 1.0, color: Color.fromARGB(121, 22, 100, 33)),
                    backgroundColor: Color.fromARGB(121, 22, 60, 33),

                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );*/


