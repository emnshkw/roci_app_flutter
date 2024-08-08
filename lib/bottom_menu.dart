import 'package:flutter/material.dart';
import 'package:roci_app/assets/roci_app_icons.dart';

class BottomMenuBar extends StatelessWidget {
  final int currentIndex;
  final BuildContext context;

  const BottomMenuBar({super.key, required this.currentIndex,required this.context});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                // BottomMenu.history,
                RociAppIcons.home,
                color: currentIndex == 0 ? Color(0xff89CD1E) : Color(0xffB0ADB0),
                size: 30,
              ),
              label: 'Главная'),
        BottomNavigationBarItem(
            icon: Icon(
              // BottomMenu.history,
              RociAppIcons.ticket_icon,
              color: currentIndex == 1 ? Color(0xff89CD1E) : Color(0xffB0ADB0),
              size: 30,
            ),
            label: 'Мои прогнозы'),
          BottomNavigationBarItem(
              icon: Icon(
                // BottomMenu.history,
                RociAppIcons.profile_icon,
                color: currentIndex == 2 ? Color(0xff89CD1E) : Color(0xffB0ADB0),
                size: 30,
              ),
              label: 'Профиль'),
        ],
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xff89CD1E),
        unselectedItemColor: const Color(0xff000000),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          if (index == 3 && currentIndex != 3) {
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (_, __, ___) => ProfilePage(),
            //     transitionDuration: Duration(milliseconds: 300),
            //     transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
            //   ),
            // );
          }
        });
  }
}
