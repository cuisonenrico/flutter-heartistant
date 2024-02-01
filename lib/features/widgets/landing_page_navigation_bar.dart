import 'package:flutter/material.dart';
import 'package:flutter_heartistant/utilities/colors.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';

const double _iconSize = 25;

class LandingPageNavigationBar extends StatelessWidget {
  const LandingPageNavigationBar({
    required this.onChangePageViewIndex,
    required this.pageViewIndex,
    super.key,
  });

  final ValueChanged<int> onChangePageViewIndex;

  final int pageViewIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.25,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => onChangePageViewIndex(PageViewList.ONE.index),
                    child: Icon(
                      Icons.looks_one_sharp,
                      size: _iconSize * (pageViewIndex == PageViewList.ONE.index ? 1.2 : 1.0),
                      color: pageViewIndex == PageViewList.ONE.index ? Colors.blueAccent : mediumGrey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onChangePageViewIndex(PageViewList.TWO.index),
                    child: Icon(
                      Icons.looks_two,
                      size: _iconSize * (pageViewIndex == PageViewList.TWO.index ? 1.2 : 1.0),
                      color: pageViewIndex == PageViewList.TWO.index ? Colors.blueAccent : mediumGrey,
                    ),
                  ),
                  const SizedBox(),
                  GestureDetector(
                    onTap: () => onChangePageViewIndex(PageViewList.THREE.index),
                    child: Icon(
                      Icons.looks_3,
                      size: _iconSize * (pageViewIndex == PageViewList.THREE.index ? 1.2 : 1.0),
                      color: pageViewIndex == PageViewList.THREE.index ? Colors.blueAccent : mediumGrey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onChangePageViewIndex(PageViewList.PROFILE.index),
                    child: Icon(
                      Icons.person,
                      size: _iconSize * (pageViewIndex == PageViewList.PROFILE.index ? 1.2 : 1.0),
                      color: pageViewIndex == PageViewList.PROFILE.index ? Colors.blueAccent : mediumGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle the center item tap
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2633C5),
                            Color(0xFF6A88E5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(4.0, 8.0),
                            blurRadius: 16.0,
                          ),
                        ]),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
