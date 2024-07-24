import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/premium_bg.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white.withOpacity(0.2),
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
              ),
              title: Text(
                'Premium',
                style: TextStyle(
                  fontFamily: 'SF Pro Rounded',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  height: 23.87 / 20,
                  color: const Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              toolbarHeight: 44.h,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 18.sp),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 110.h),
                Column(
                  children: [
                    Text(
                      'TAPE \nUNVEILER',
                      style: TextStyle(
                        fontFamily: 'ITC Benguiat Std',
                        fontWeight: FontWeight.w700,
                        fontSize: 38.r,
                        height: 45.61 / 38,
                        color: const Color(0xFFF2C40F),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 100.h),
                    Image.asset(
                      'assets/element11.png',
                      width: 97.54.w,
                      height: 111.h,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'NO ADS FOR',
                      style: TextStyle(
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                        height: 28.64 / 24,
                        color: const Color(0xFF000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      '\$0.49',
                      style: TextStyle(
                        fontFamily: 'ITC Benguiat Std',
                        fontWeight: FontWeight.w700,
                        fontSize: 40.sp,
                        height: 48.01 / 40,
                        color: const Color(0xFF000000),
                        letterSpacing: 10.0,
                        shadows: const [
                          Shadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Container(
                                width: 335.w,
                                height: 415.37.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/premium_dialog_bg.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.r,
                                      ),
                                      Text(
                                        'ADS FREE',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Rounded',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24.r,
                                          height: 28.64 / 24,
                                          color: const Color(0xFF000000),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 140.r),
                                      Text(
                                        'FOR',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Rounded',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24.r,
                                          height: 28.64 / 24,
                                          color: const Color(0xFF000000),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(
                                        '\$0.49',
                                        style: TextStyle(
                                          fontFamily: 'ITC Benguiat Std',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 36.r,
                                          height: 43.21 / 36,
                                          letterSpacing: 10.0,
                                          color: const Color(0xFF000000),
                                          shadows: const [
                                            Shadow(
                                              offset: Offset(0, 4),
                                              blurRadius: 4,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.25),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20.r),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: Container(
                                            width: 335.w,
                                            height: 48.h,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  224, 186, 53, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                width: 1,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 1),
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
                                                  height: 16 / 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.r),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Restore',
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Rounded',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            height: 16 / 16,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 335.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(175, 0, 0, 1),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            width: 1,
                          ),
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
                            'Get Premium for \$0.49',
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
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Terms of Use',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 20 / 14,
                            letterSpacing: -0.4,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Restore',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 20 / 14,
                            letterSpacing: -0.4,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 20 / 14,
                            letterSpacing: -0.4,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
