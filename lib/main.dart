import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/main_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirstTime = true;
  bool _isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
    _checkPremiumStatus();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      prefs.setBool('isFirstTime', false);
    }

    setState(() {
      _isFirstTime = isFirstTime;
    });
  }

  Future<void> _checkPremiumStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPremium = prefs.getBool('isPremiumUser') ?? false;

    setState(() {
      _isPremiumUser = isPremium;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'TapeUnveiler',
          debugShowCheckedModeBanner: false,
          home: _isFirstTime ? OnboardingScreen() : MainScreen(),
          routes: {
            '/onboarding': (context) => OnboardingScreen(),
            '/main': (context) => MainScreen(),
            '/settings': (context) => SettingsScreen(),
          },
        );
      },
    );
  }
}
