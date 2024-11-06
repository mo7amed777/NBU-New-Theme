import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

BottomNavigationBar buildBottomNavBar({
  required dynamic controller,
  required String firstLabel,
  required String secondlabel,
  required String thirdLabel,
  required IconData firstIcon,
  required IconData secondIcon,
  required IconData thirdIcon,
}) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    unselectedItemColor: colorBlackLight,
    backgroundColor: Colors.transparent,
    selectedItemColor: colorPrimary,
    elevation: 0.0,
    items: [
      BottomNavigationBarItem(
        icon: Icon(firstIcon),
        label: firstLabel,
      ),
      BottomNavigationBarItem(
        icon: Icon(secondIcon),
        label: secondlabel,
      ),
      BottomNavigationBarItem(
        icon: Icon(thirdIcon),
        label: thirdLabel,
      ),
    ],
    currentIndex: controller.index,
    onTap: (index) {
      controller.changeIndex(index);
    },
  );
}
