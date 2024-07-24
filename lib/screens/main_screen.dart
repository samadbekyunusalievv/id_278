import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:id_278/screens/guess_the_film_screen.dart';
import 'package:id_278/screens/rules_screen.dart';
import 'package:id_278/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    GuessTheFilmScreen(),
    RulesScreen(),
    SettingsScreen(),
  ];

  static const List<String> _titles = <String>[
    'Guess the film',
    'Rules',
    'Settings',
  ];

  static const List<String> _iconPaths = [
    'assets/icons/guess_film.png',
    'assets/icons/rules.png',
    'assets/icons/settings.png',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIcon(int index) {
    return Opacity(
      opacity: _selectedIndex == index ? 1.0 : 0.4,
      child: Image.asset(
        _iconPaths[index],
        width: 30.r,
        height: 32.r,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
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
                offset: Offset(0, 4),
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
          _titles[_selectedIndex],
          style: TextStyle(
            fontFamily: 'SF Pro Rounded',
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
            height: 23.87 / 20,
            color: Color(0xFF000000),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: 44.h,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0BA35),
            ),
          ),
          _pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF000000), width: 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: _buildIcon(0),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildIcon(1),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildIcon(2),
                      label: '',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.transparent,
                  unselectedItemColor: Colors.transparent,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  iconSize: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
