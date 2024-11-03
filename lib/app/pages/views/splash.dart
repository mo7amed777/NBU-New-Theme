import 'package:eservices/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eservices/app/data/local/my_shared_pref.dart';
import 'package:eservices/app/routes/app_pages.dart';
import 'package:eservices/config/theme/app_styles.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimationN;
  late Animation<Offset> _slideAnimationB;
  late Animation<Offset> _slideAnimationU;

  void _initControllers() {
    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Rotation animation (rotate 360 degrees)
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * 3.14159265359).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Opacity animation (fade in)
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.1, 1.0, curve: Curves.easeIn)),
    );

    // Slide animations for each letter coming in from different directions
    _slideAnimationN =
        Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1, 0.6, curve: Curves.easeOut)),
    );

    _slideAnimationB =
        Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2, 0.7, curve: Curves.easeOut)),
    );

    _slideAnimationU =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Interval(0.3, 0.8, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
    _controller.forward().whenComplete(() {
      if (MySharedPref.getIsAuthenticated()) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  Widget _buildAnimatedLetter(String letter, Animation<Offset> slideAnimation) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value, // Rotate each letter
            child: SlideTransition(
              position: slideAnimation, // Apply slide effect
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary, // Customize the background color
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            _buildAnimatedLetter('N', _slideAnimationN),
            _buildAnimatedLetter('B', _slideAnimationB),
            _buildAnimatedLetter('U', _slideAnimationU),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
