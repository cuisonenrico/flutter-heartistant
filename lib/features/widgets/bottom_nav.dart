import 'package:flutter/material.dart';
import 'package:flutter_heartistant/utilities/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.onChangePageViewIndex,
    required this.pageViewIndex,
    super.key,
  });

  final ValueChanged<int> onChangePageViewIndex;

  final int pageViewIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageViewIndex,
      onTap: (index) {
        onChangePageViewIndex(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.looks_one_sharp,
            color: mediumGrey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.looks_two,
            color: mediumGrey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.looks_3,
            color: mediumGrey,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: mediumGrey,
          ),
          label: '',
        ),
      ],
    );
  }
}
