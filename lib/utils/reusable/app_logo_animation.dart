import 'package:flutter/material.dart';
import 'package:shopify/data/screen.dart';
import 'package:shopify/resource/assets/app_images.dart';

class AppLogoAnimation extends StatefulWidget {
  const AppLogoAnimation({super.key});

  @override
  State<AppLogoAnimation> createState() => _AppLogoAnimationState();
}

class _AppLogoAnimationState extends State<AppLogoAnimation> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    reverseDuration: const Duration(seconds: 10),
  )..repeat(reverse: true);

  late final Animation<double> _aniamtion = CurvedAnimation(
    parent: _controller, 
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    return FadeTransition(
      opacity: _aniamtion,
      child: Image.asset(AppImages.appLogo,
        height: height * 0.1,
        width: height * 0.1,
        fit: BoxFit.cover,
      ),
    );
  }
}