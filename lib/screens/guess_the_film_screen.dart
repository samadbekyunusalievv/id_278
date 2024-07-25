import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'premium_screen.dart';

class GuessTheFilmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GuessTheFilmInnerScreen(),
      ),
    );
  }
}

class GuessTheFilmInnerScreen extends StatefulWidget {
  const GuessTheFilmInnerScreen({Key? key}) : super(key: key);

  @override
  _GuessTheFilmInnerScreenState createState() =>
      _GuessTheFilmInnerScreenState();
}

class _GuessTheFilmInnerScreenState extends State<GuessTheFilmInnerScreen> {
  final List<String> movies = [
    'DRACULA',
    'GRAVITY',
    'HIDALGO',
    'MACBETH',
    'ROBOCOP',
    'SABRINA',
    'TITANIC',
    'TRAITOR',
    'MONSTER',
    'ALADDIN',
    'BEOWULF',
    'AMADEUS',
    'HANCOCK',
    'CAMELOT'
  ];

  List<String> displayLetters = [];
  List<Color> gridColors = [];
  List<bool> visibilityStates = List.filled(10, false);
  List<bool> errorStates = List.filled(7, false);
  int currentMovieIndex = 0;
  String selectedMovie = '';
  String message = 'USE THE SUNGLASSES!';
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  late Offset glassesPosition;
  late Offset defaultPosition;
  late Offset touchOffset;
  bool isDragging = false;
  Timer? _closeDialogTimer;
  bool _isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    defaultPosition = Offset(ScreenUtil().screenWidth * 0.46 - 79.r / 2, 540.r);
    glassesPosition = defaultPosition;
    _loadMovieIndex();
    _checkPremiumStatus();
  }

  Future<void> _checkPremiumStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPremium = prefs.getBool('isPremiumUser') ?? false;

    setState(() {
      _isPremiumUser = isPremium;
    });
  }

  Future<void> _loadMovieIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentMovieIndex = prefs.getInt('currentMovieIndex') ?? 0;
      _startNewGame();
    });
  }

  Future<void> _saveMovieIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentMovieIndex', currentMovieIndex);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _closeDialogTimer?.cancel();
    super.dispose();
  }

  void _startNewGame() {
    selectedMovie = movies[currentMovieIndex];
    displayLetters = selectedMovie.split('')..addAll(_generateRandomLetters(3));
    displayLetters.shuffle();
    gridColors = List.generate(
        10,
        (_) => Random().nextBool()
            ? const Color.fromRGBO(175, 0, 0, 1)
            : const Color.fromRGBO(3, 126, 178, 1));
    controllers = List.generate(7, (_) => TextEditingController());
    focusNodes = List.generate(7, (_) => FocusNode());
    message = 'USE THE SUNGLASSES!';
    errorStates = List.filled(7, false);
    visibilityStates = List.filled(10, false);
  }

  List<String> _generateRandomLetters(int count) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(
        count, (_) => alphabet[Random().nextInt(alphabet.length)]);
  }

  void _updateVisibility(Offset localPosition) {
    double gridWidth = 61.r;
    double gridHeight = 41.r;
    double startX = (ScreenUtil().screenWidth - gridWidth * 5 - 2.15.r * 4) / 2;
    double startY = 225.r;
    Offset blueCenter = glassesPosition + Offset(41.5.r, 33.5.r);
    Offset redCenter = glassesPosition + Offset(159.r, 33.5.r);

    for (int i = 0; i < 10; i++) {
      int row = i ~/ 5;
      int col = i % 5;
      double x = startX + col * (gridWidth + 2.15.r);
      double y = startY + row * (gridHeight + 39.r);
      Rect gridRect = Rect.fromLTWH(x, y, gridWidth, gridHeight);
      visibilityStates[i] = (gridRect.contains(blueCenter) &&
              gridColors[i] == const Color.fromRGBO(3, 126, 178, 1)) ||
          (gridRect.contains(redCenter) &&
              gridColors[i] == const Color.fromRGBO(175, 0, 0, 1));
    }
  }

  void _checkAnswer() {
    String userAnswer = controllers.map((e) => e.text).join('');
    if (controllers.every((controller) => controller.text.length == 1)) {
      if (userAnswer.toUpperCase() == selectedMovie) {
        if (currentMovieIndex < movies.length - 1) {
          currentMovieIndex++;
        } else {
          currentMovieIndex = 0;
        }
        _saveMovieIndex();
        if (!_isPremiumUser) {
          _showPremiumDialog();
        } else {
          _showNextDialog();
        }
      } else {
        setState(() {
          errorStates = List.filled(7, true);
          message = "THE TITLE OF THE FILM IS WRONG!";
          Vibration.vibrate(duration: 1000);
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              errorStates = List.filled(7, false);
              message = "USE THE SUNGLASSES!";
              for (var controller in controllers) {
                controller.clear();
              }
            });
          }
        });
      }
    }
  }

  void _showPremiumDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _closeDialogTimer = Timer(Duration(seconds: 3), () {
          if (mounted && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
            _showNextDialog();
          }
        });

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
                image: AssetImage('assets/premium_dialog_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.r),
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
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.r),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _closeDialogTimer?.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PremiumScreen(
                              onStatusChanged: _checkPremiumStatus),
                        ),
                      ).then((_) {
                        _showNextDialog();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        width: 335.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(224, 186, 53, 1),
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
                      _closeDialogTimer?.cancel();
                      _showNextDialog();
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
  }

  void _showNextDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              width: 335.w,
              height: 420.h,
              decoration: BoxDecoration(
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/next_dialog.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15.h),
                  Text(
                    'CONGRATULATIONS!',
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w500,
                      fontSize: 24.r,
                      height: 28.64 / 24,
                      color: const Color(0xFF000000),
                      letterSpacing: 0.27,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 206.h),
                  Text(
                    'YOU GUESSED THE FILM...',
                    style: TextStyle(
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      height: 19.09 / 16,
                      color: const Color(0xFF000000),
                      letterSpacing: 0.27,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    selectedMovie.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'ITC Benguiat Std',
                      fontWeight: FontWeight.w700,
                      fontSize: 32.r,
                      height: 38.41 / 32,
                      letterSpacing: 15.0,
                      color: const Color(0xFF000000),
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
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      width: 295.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(224, 186, 53, 1),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: const Color(0xFF000000),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF000000),
                            offset: Offset(2, 2),
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (mounted) {
                            setState(() {
                              _startNewGame();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: 'SF Pro Rounded',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              height: 1.0,
                              color: const Color(0xFF000000),
                              letterSpacing: 0.27,
                            ),
                          ),
                        ),
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
      visibilityStates = List.filled(10, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDataInitialized = displayLetters.isNotEmpty &&
        gridColors.isNotEmpty &&
        controllers.length == 7 &&
        focusNodes.length == 7;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              color: const Color.fromRGBO(224, 186, 53, 1),
            ),
            if (isDataInitialized)
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Positioned(
                        left: ScreenUtil().screenWidth * 0.035,
                        right: ScreenUtil().screenWidth * 0.074,
                        top: ScreenUtil().screenHeight * 0.267,
                        child: Transform.rotate(
                          angle: pi,
                          child: Image.asset(
                            'assets/element1.png',
                            width: ScreenUtil().screenWidth * 0.95,
                            height: ScreenUtil().screenHeight * 0.074,
                          ),
                        ),
                      ),
                      Positioned(
                        right: ScreenUtil().screenWidth * 0.04,
                        left: ScreenUtil().screenWidth * 0.074,
                        top: ScreenUtil().screenHeight * 0.3680,
                        child: Image.asset(
                          'assets/element1.png',
                          width: ScreenUtil().screenWidth * 0.95,
                          height: ScreenUtil().screenHeight * 0.074,
                        ),
                      ),
                      Positioned(
                        left: ScreenUtil().screenWidth * 0.03,
                        right: ScreenUtil().screenWidth * 0.03,
                        top: ScreenUtil().screenHeight * 0.487,
                        child: Image.asset(
                          'assets/element2.png',
                          width: ScreenUtil().screenWidth * 0.10,
                          height: ScreenUtil().screenHeight * 0.0525,
                        ),
                      ),
                      Positioned(
                        top: 108.h,
                        left: -55.w,
                        child: Image.asset(
                          'assets/element4.png',
                          width: 119.w,
                          height: 97.67.h,
                        ),
                      ),
                      Positioned(
                        top: 108.h,
                        right: -55.w,
                        child: Image.asset(
                          'assets/element5.png',
                          width: 119.w,
                          height: 97.67.h,
                        ),
                      ),
                      Positioned(
                        top: 623.h,
                        left: 279.w,
                        child: Image.asset(
                          'assets/element6.png',
                          width: 143.33.w,
                          height: 127.78.h,
                        ),
                      ),
                      Positioned(
                        top: 118.h,
                        left: 0,
                        right: 0,
                        child: Text(
                          'GUESS THE TITLE \n OF THE FILM',
                          style: TextStyle(
                            fontFamily: 'ITC Benguiat Std',
                            fontWeight: FontWeight.w700,
                            fontSize: 24.sp,
                            height: 28.8 / 24,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 225.r),
                          _buildFilmStrip(rowIndex: 0),
                          SizedBox(height: 39.r),
                          _buildFilmStrip(rowIndex: 1),
                          SizedBox(height: 50.r),
                          _buildInputFields(),
                          SizedBox(height: 30.r),
                          Text(
                            message,
                            style: TextStyle(
                              fontFamily: 'ITC Benguiat Std',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              height: 16.8 / 14,
                              color: errorStates.contains(true)
                                  ? const Color.fromRGBO(175, 0, 0, 1)
                                  : Colors.black.withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      if (isDragging)
                        Stack(
                          children: [
                            _buildOverlay(),
                            ..._buildVisibleLetters(),
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
                              child: _build3DGlasses(),
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
      ),
    );
  }

  Widget _buildInputFields() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(7, (index) {
          return Container(
            width: 43.r,
            height: 31.r,
            margin: EdgeInsets.symmetric(horizontal: 1.r),
            child: Center(
              child: TextField(
                focusNode: focusNodes[index],
                controller: controllers[index],
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 7.r),
                  filled: true,
                  fillColor: errorStates[index] ? Colors.red : Colors.white,
                  counterText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: errorStates[index] ? Colors.white : Colors.white,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontFamily: 'ITC Benguiat Std',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.r,
                  height: 28.8 / 24,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                onChanged: (value) {
                  controllers[index].text = value.toUpperCase();
                  controllers[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: controllers[index].text.length),
                  );
                  if (value.length == 1) {
                    if (index < 6) {
                      focusNodes[index].unfocus();
                      FocusScope.of(context)
                          .requestFocus(focusNodes[index + 1]);
                    } else {
                      focusNodes[index].unfocus();
                    }
                  }
                  _checkAnswer();
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFilmStrip({required int rowIndex}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 27.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          int actualIndex = rowIndex * 5 + index;
          return Container(
            width: 61.r,
            height: 41.r,
            margin: EdgeInsets.all(2.15.r / 2),
            decoration: BoxDecoration(
              color: gridColors[actualIndex],
              borderRadius: BorderRadius.circular(4.r),
            ),
            alignment: Alignment.center,
            child: Visibility(
              visible: visibilityStates[actualIndex],
              child: Text(
                displayLetters[actualIndex],
                style: TextStyle(
                  fontFamily: 'ITC Benguiat Std',
                  fontWeight: FontWeight.w700,
                  fontSize: 24.r,
                  height: 28.8 / 24,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _build3DGlasses() {
    return Row(
      children: [
        Container(
          width: 79.r,
          height: 63.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Colors.blue.withOpacity(0.6),
            border: Border.all(color: Colors.black, width: 4.r),
          ),
        ),
        SizedBox(width: 38.r),
        Container(
          width: 79.r,
          height: 63.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: Colors.red.withOpacity(0.6),
            border: Border.all(color: Colors.black, width: 4.r),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicElement3() {
    return Positioned(
      left: glassesPosition.dx + -101.r,
      top: glassesPosition.dy + -25.r,
      child: Image.asset(
        'assets/element3.png',
        width: 324.r,
        height: 105.r,
      ),
    );
  }

  List<Widget> _buildVisibleLetters() {
    double gridWidth = 61.r;
    double gridHeight = 41.r;
    double startX = (ScreenUtil().screenWidth - gridWidth * 5 - 2.15.r * 4) / 2;
    double startY = 225.r;

    return List.generate(10, (index) {
      if (!visibilityStates[index]) return const SizedBox.shrink();

      int row = index ~/ 5;
      int col = index % 5;
      double x = startX + col * (gridWidth + 2.15.r);
      double y = startY + row * (gridHeight + 39.r);

      return Positioned(
        left: x,
        top: y,
        child: Container(
          width: 61.r,
          height: 41.r,
          decoration: BoxDecoration(
            color: gridColors[index],
            borderRadius: BorderRadius.circular(4.r),
          ),
          alignment: Alignment.center,
          child: Text(
            displayLetters[index],
            style: TextStyle(
              fontFamily: 'ITC Benguiat Std',
              fontWeight: FontWeight.w700,
              fontSize: 24.r,
              height: 28.8 / 24,
              color: Colors.black,
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
}
