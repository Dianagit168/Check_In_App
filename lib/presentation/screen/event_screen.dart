// import 'package:check_in_app/index.dart';

// class EventScreen extends StatelessWidget {
//   const EventScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 10, 24, 60),
//       appBar: AppBar(
//         title: const Text('Events'),
//       ),
//       body: GridView.builder(
//         physics: const BouncingScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 1,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           mainAxisExtent: 330,
//         ),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ScanQr(eventTitle: eventData[index].tit!),
//                 )
//               ),
//               child: Container(
//                 height: 300,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(16),
//                   ),
//                 ),
//                 child: Card(
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   color: eventData[index].color,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.network(
//                         '${eventData[index].img}',
//                         fit: BoxFit.contain,
//                         height: 170,
//                         width: 170,
//                       ),
//                       Stack(
//                         alignment: Alignment.bottomLeft,
//                         children: [
//                           Container(
//                             height: 100,
//                             width: MediaQuery.of(context).size.width,
//                             color: const Color.fromRGBO(37, 67, 148, 1),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 40),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 40),
//                                     child: Text(
//                                       '${eventData[index].tit}',
//                                       style: const TextStyle(
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 100),
//                                     child: Row(
//                                       children: [
//                                         const Icon(
//                                           LucideIcons.mapPin,
//                                           color: Colors.white,
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           '${eventData[index].location}',
//                                           style: const TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 80,
//                               width: 80,
//                               decoration: const BoxDecoration(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(16),
//                                   ),
//                                   color: Color.fromARGB(255, 232, 216, 221)),
//                               child: Center(
//                                 child: Text(
//                                   '${eventData[index].date}',
//                                   style: const TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         itemCount: eventData.length,
//       ),
//     );
//   }
// }
