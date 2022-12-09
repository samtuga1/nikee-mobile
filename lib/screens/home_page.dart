import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:nikee/widgets/my_appbar.dart';
import 'dart:math' show pi;

import '../widgets/home_content.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double turns = -(1 / 18);

  final List<String> shoes = [
    'All',
    'Air Max',
    'Presto',
    'Hurache',
    'Jordan',
    'Air Force',
    'Puma',
  ];

  final List cardColor = [
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.brown,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.green,
    Colors.lightBlueAccent
  ];

// 44 is == MediaQuery.of(context).padding.top after printing it in the build method
  double cardPositionTop = 44 + kToolbarHeight;
  double cardPositionRight = 0;
  double shoePositionRight = -40;
  int selected = 0;
  int pressed = 30;
  double cardHeight = 220;
  double cardWidth = 183;
  double cardRadius = 11;
  int cardDuration = 650;
  Offset initCardSlideOffset = Offset.zero;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: cardDuration),
            child: isActive ? const DetailPage() : HomeContent(shoes: shoes),
          ),
          SizedBox(
            height: 235 + MediaQuery.of(context).padding.top + kToolbarHeight,
            child: Swiper(
              onTap: (val) {
                isActive = true;
                setState(() {
                  pressed = val;
                });
              },
              onIndexChanged: (value) {
                selected = value;
              },
              itemBuilder: (BuildContext context, int index) {
                return AnimatedSlide(
                  curve: isActive ? Curves.linear : Curves.easeInOut,
                  duration: Duration(milliseconds: isActive ? 5500 : 1000),
                  offset: pressed != 30
                      ? index < pressed
                          ? const Offset(-3, 0)
                          : index > pressed
                              ? const Offset(3, 0)
                              : initCardSlideOffset
                      : Offset.zero,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerRight,
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: cardDuration),
                        top: pressed == index ? -180 : cardPositionTop,
                        right: pressed == index ? -130 : cardPositionRight,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: cardDuration),
                          width: pressed == index ? 440 : cardWidth,
                          height: pressed == index ? 440 : cardHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                pressed == index ? 223 : cardRadius),
                            color: cardColor[index],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Alpha Savage',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "GHS 64.99",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.white54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration(
                            milliseconds:
                                pressed == index ? cardDuration : 300),
                        top: pressed == index
                            ? cardPositionTop + 45
                            : cardPositionTop + 60,
                        right: pressed == index ? 50 : shoePositionRight,
                        child: AnimatedRotation(
                          curve: Curves.easeOut,
                          turns: pressed == index
                              ? 0
                              : selected == index
                                  ? turns
                                  : -(1 / 7),
                          duration: Duration(milliseconds: cardDuration),
                          child: SizedBox(
                            height: 100,
                            width: 200,
                            child: Image.asset(
                              'assets/${index + 1}.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: 10,
              viewportFraction: 0.62,
              scale: 1,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.top + kToolbarHeight,
            child: MyAppBar(
              goBack: () {
                if (isActive) {
                  setState(() {
                    isActive = false;
                    pressed = 30;
                  });
                } else {
                  return;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
