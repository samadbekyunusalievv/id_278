import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: RulesInnerScreen(),
      ),
    );
  }
}

class RulesInnerScreen extends StatefulWidget {
  const RulesInnerScreen({Key? key}) : super(key: key);

  @override
  _RulesInnerScreenState createState() => _RulesInnerScreenState();
}

class _RulesInnerScreenState extends State<RulesInnerScreen> {
  List<bool> visibilityStates = List.filled(2, false);
  late Offset glassesPosition;
  late Offset defaultPosition;
  late Offset touchOffset;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    defaultPosition =
        Offset(ScreenUtil().screenWidth * 0.48 - 94.02.r / 2 - 15, 403.r + 25);
    glassesPosition = defaultPosition;
  }

  void _updateVisibility(Offset localPosition) {
    double gridWidth = 144.r;
    double gridHeight = 99.r;
    double startX = (ScreenUtil().screenWidth - gridWidth * 2 - 6.r) / 2 + 9.r;
    double startY = 243.r;
    Offset blueCenter =
        glassesPosition + Offset(47.01.r, 37.945.r); // Adjusted for new size
    Offset redCenter =
        glassesPosition + Offset(184.03.r, 37.945.r); // Adjusted for new size

    for (int i = 0; i < 2; i++) {
      double x = startX + i * (gridWidth + 6.r);
      double y = startY;
      Rect gridRect = Rect.fromLTWH(x, y, gridWidth, gridHeight);
      visibilityStates[i] = (gridRect.contains(blueCenter) && i == 0) ||
          (gridRect.contains(redCenter) && i == 1);
    }
  }

  void _startDragging(Offset localPosition) {
    setState(() {
      isDragging = true;
      touchOffset = localPosition - glassesPosition;
    });
  }

  void _endDragging() {
    setState(() {
      isDragging = false;
      glassesPosition = defaultPosition;
      visibilityStates = List.filled(2, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(224, 186, 53, 1),
          ),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    right: (ScreenUtil().screenWidth - 385.r) / 2,
                    top: ScreenUtil().screenHeight * 0.273,
                    child: Image.asset(
                      'assets/element7.png',
                      width: 351.r,
                      height: 143.29.r,
                    ),
                  ),
                  Positioned(
                    top: 243.r,
                    left:
                        (ScreenUtil().screenWidth - 144.r * 2 - 6.r) / 2 + 9.r,
                    child: Row(
                      children: [
                        _buildGrid(0, Color.fromRGBO(3, 126, 178, 1), 'A'),
                        SizedBox(width: 6.r),
                        _buildGrid(1, Color.fromRGBO(237, 28, 36, 1), 'B'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 118.h,
                    left: 0,
                    right: 0,
                    child: Text(
                      'USE YOUR GLASSES TO FIND THE \n LETTERS. MAKE A MOVIE TITLE \n OUT OF THE LETTERS YOU FIND.',
                      style: TextStyle(
                        fontFamily: 'ITC Benguiat Std',
                        fontWeight: FontWeight.w400,
                        fontSize: 20.sp,
                        height: 24 / 20,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    top: 374.r,
                    left: -85.r,
                    child: Image.asset(
                      'assets/element8.png',
                      width: 137.84.r,
                      height: 137.12.r,
                    ),
                  ),
                  Positioned(
                    top: 562.r,
                    right: -30,
                    child: Image.asset(
                      'assets/element9.png',
                      width: 142.93.r,
                      height: 150.06.r,
                    ),
                  ),
                  if (isDragging)
                    Stack(
                      children: [
                        _buildOverlay(),
                        ..._buildVisibleLetters(), // Add visible letters on top of overlay but below sunglasses
                      ],
                    ),
                  GestureDetector(
                    onPanStart: (details) {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      Offset localPosition =
                          renderBox.globalToLocal(details.globalPosition);
                      _startDragging(localPosition);
                    },
                    onPanUpdate: (details) {
                      RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      Offset localPosition =
                          renderBox.globalToLocal(details.globalPosition);
                      setState(() {
                        glassesPosition = localPosition - touchOffset;
                        _updateVisibility(localPosition);
                      });
                    },
                    onPanEnd: (details) {
                      _endDragging();
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          left: glassesPosition.dx,
                          top: glassesPosition.dy,
                          child: _buildSunglasses(),
                        ),
                        _buildDynamicElement3(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(int index, Color color, String letter) {
    return Container(
      width: 144.r,
      height: 99.r,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.r),
      ),
      alignment: Alignment.center,
      child: Visibility(
        visible: visibilityStates[index],
        child: Text(
          letter,
          style: TextStyle(
            fontFamily: 'ITC Benguiat Std',
            fontWeight: FontWeight.w700,
            fontSize: 48.sp,
            height: 57.61 / 48,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildSunglasses() {
    return Row(
      children: [
        Container(
          width: 94.02.r,
          height: 75.89.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Colors.blue.withOpacity(0.6),
            border: Border.all(color: Colors.black, width: 4.r),
          ),
        ),
        SizedBox(width: 43.r),
        Container(
          width: 94.02.r,
          height: 75.89.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Colors.red.withOpacity(0.6),
            border: Border.all(color: Colors.black, width: 4.r),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildVisibleLetters() {
    double gridWidth = 144.r;
    double gridHeight = 99.r;
    double startX = (ScreenUtil().screenWidth - gridWidth * 2 - 6.r) / 2 + 9.r;
    double startY = 243.r;

    return List.generate(2, (index) {
      if (!visibilityStates[index]) return SizedBox.shrink();

      double x = startX + index * (gridWidth + 6.r);
      double y = startY;

      return Positioned(
        left: x,
        top: y,
        child: Container(
          width: 144.r,
          height: 99.r,
          decoration: BoxDecoration(
            color: index == 0
                ? Color.fromRGBO(3, 126, 178, 1)
                : Color.fromRGBO(237, 28, 36, 1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          alignment: Alignment.center,
          child: Text(
            index == 0 ? 'A' : 'B',
            style: TextStyle(
              fontFamily: 'ITC Benguiat Std',
              fontWeight: FontWeight.w700,
              fontSize: 48.sp,
              height: 57.61 / 48,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildDynamicElement3() {
    return Positioned(
      left: glassesPosition.dx + -120.r,
      top: glassesPosition.dy + -26.5.r,
      child: Image.asset(
        'assets/element3.png',
        width: 387.r, // Double the size for a bigger element
        height: 120.r, // Double the size for a bigger element
      ),
    );
  }
}
