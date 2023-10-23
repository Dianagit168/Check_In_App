import 'package:check_in_app/screen/category_event.dart';
import 'package:check_in_app/screen/evevnt.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MainTap extends StatelessWidget {
  const MainTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            allScreen(context),
            subTabBar(context),
          ],
        ),
      ),
    );
  }
}

Widget allScreen(BuildContext context) {
  return const TabBarView(
    children: [
      CategoryEvents(),
      Event(),
      Center(child: Text('User Account')),
    ],
  );
}

Widget subTabBar(BuildContext context) {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: const Color.fromARGB(204, 37, 67, 148),
      border: Border.all(
        width: 2,
        color: const Color.fromARGB(137, 2, 28, 60),
      ),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    ),
    child: const TabBar(
      padding: EdgeInsets.all(10),
      indicatorColor: Colors.white,
      indicatorWeight: 5,
      unselectedLabelColor: Color.fromARGB(255, 26, 31, 43),
      labelColor: Colors.white,
      tabs: [
        Tab(
          icon: Icon(
            LucideIcons.home,
            size: 27,
          ),
        ),
        Tab(
          icon: Icon(
            LucideIcons.calendarCheck,
            size: 24,
          ),
        ),
        Tab(
          icon: Icon(
            LucideIcons.user,
            size: 24,
          ),
        ),
      ],
    ),
  );
}
