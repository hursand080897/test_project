import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injir_new/options_item.dart';
import 'package:injir_new/page1.dart';
import 'package:injir_new/page2.dart';
import 'package:injir_new/page3.dart';
import 'package:injir_new/page4.dart';
import 'package:injir_new/page5.dart';
import 'package:injir_new/values/colors.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _page = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _page = 0;
    });
  }

  final List<Widget> bottomBarPages = [
    Navigator(
      onGenerateRoute: (settings) {
        Widget page = Page1();
        if (settings.name == 'page2') page = OptionsItem();
        return MaterialPageRoute(builder: (_) => page);
      },
    ),
    const Page2(),
    const Page3(),
    const Page4(),
    const Page4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Title'),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          height: 100,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  color: AppColors.primary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60,
                        color: Color.fromARGB(0, 255, 255, 255),
                        child: Image.asset(
                          "assets/images/home.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 60,
                        child: Image.asset(
                          "assets/images/category.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                        height: 80,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                          child: Image.asset(
                            "assets/images/karzina.png",
                            color: Colors.white,
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        3,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 60,
                        child: Image.asset(
                          "assets/images/user.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        4,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 60,
                        child: Image.asset(
                          "assets/images/gear.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
