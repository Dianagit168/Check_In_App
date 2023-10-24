// import 'package:check_in_app/index.dart';

// class MainTap extends StatelessWidget {
//   MainTap({Key? key}) : super(key: key);

//   final List<Widget> screen = [
//     const RunWithSaiScreen(),
//     // EventScreen(),
//     // const Center(child: Text('User Account')),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: screen.length,
//       child: Scaffold(
//         body: _allScreen(context),
//         // bottomNavigationBar: _subTabBar(context),
//       ),
//     );
//   }

//   Widget _allScreen(BuildContext context) {
//     return TabBarView(
//       children: screen
//     );
//   }

//   Widget _subTabBar(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
//       decoration: const BoxDecoration(
//         color: Color.fromRGBO(130, 102, 224, 1),
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       child: const TabBar(
//         padding: EdgeInsets.all(10),
//         indicatorColor: Colors.white,
//         indicatorWeight: 5,
//         unselectedLabelColor: Color.fromARGB(255, 26, 31, 43),
//         labelColor: Colors.white,
//         tabs: [
//           Tab(
//             icon: Icon(
//               LucideIcons.home,
//               size: 27,
//             ),
//           ),
//           // Tab(
//           //   icon: Icon(
//           //     LucideIcons.calendarCheck,
//           //     size: 24,
//           //   ),
//           // ),
//           Tab(
//             icon: Icon(
//               LucideIcons.user,
//               size: 27,
//             ),
//           ),
//         ],
//       ),
//     );
//   }


// }

