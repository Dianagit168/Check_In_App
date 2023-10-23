import 'package:check_in_app/modelanddata/modelanddata.dart';

import 'package:check_in_app/screen/qr_scanner.dart';
import 'package:flutter/material.dart';

class CategoryEvents extends StatelessWidget {
  const CategoryEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 24, 60),
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                eventStrucutre(context, 'SPORTS EVENT'),
                eventStrucutre(context, 'EDUCATION'),
                eventStrucutre(context, 'CONCERT'),
                eventStrucutre(context, 'MOOVIE'),
                eventStrucutre(context, 'GAME'),
              ],
            )),
      ),
    );
  }

  Widget eventStrucutre(
    BuildContext context,
    final String? content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          content!,
          style: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanQr(),
                      ),
                    ),
                    child: SizedBox(
                      width: 270,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: eventData[index].color,
                        child: Image.network(
                          '${eventData[index].img}',
                          fit: BoxFit.contain,
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
