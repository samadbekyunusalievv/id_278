import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'premium_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SettingsInnerScreen(),
    );
  }
}

class SettingsInnerScreen extends StatefulWidget {
  const SettingsInnerScreen({Key? key}) : super(key: key);

  @override
  _SettingsInnerScreenState createState() => _SettingsInnerScreenState();
}

class _SettingsInnerScreenState extends State<SettingsInnerScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(224, 186, 53, 1),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  SizedBox(height: 108.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(224, 186, 53, 1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          offset: Offset(2, 2),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notifications',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            height: 1.0,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        _buildCustomSwitch(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'ADS FREE FOR',
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      height: 23.87 / 20,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    '\$0.49',
                    style: TextStyle(
                      fontFamily: 'ITC Benguiat Std',
                      fontWeight: FontWeight.w700,
                      fontSize: 36.sp,
                      height: 43.21 / 36,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      letterSpacing: 15.0,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PremiumScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(175, 0, 0, 1),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            offset: Offset(2, 2),
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'See Details',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            height: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(224, 186, 53, 1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          offset: Offset(2, 2),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            height: 1.0,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(224, 186, 53, 1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                          color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          offset: Offset(2, 2),
                          blurRadius: 0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terms of Use',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            height: 1.0,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 534.r,
            right: -25.r,
            child: Image.asset(
              'assets/element10.png',
              width: 150.07.r,
              height: 165.12.r,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSwitch() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _notificationsEnabled = !_notificationsEnabled;
        });
      },
      child: Container(
        width: 40.w,
        height: 24.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 35.w,
              height: 12.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                border: Border.all(
                    color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              left: _notificationsEnabled ? 20.w : 0,
              right: _notificationsEnabled ? 0 : 20.w,
              top: 0,
              child: Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _notificationsEnabled
                      ? const Color.fromRGBO(226, 180, 21, 1)
                      : Colors.white,
                  border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
