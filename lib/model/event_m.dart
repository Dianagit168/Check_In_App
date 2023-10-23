import 'package:check_in_app/index.dart';

class EventModel {
  final String? img;
  final String? tit;
  final Color? color;
  final String? location;
  final String? date;

  EventModel(
      {required this.img,
      required this.color,
      required this.tit,
      required this.location,
      required this.date});
}

final List<EventModel> eventData = [
  EventModel(
    img: 'https://www.dangkorsenchey.com/images/isi-dsc-logo.png',
    color: const Color.fromARGB(255, 184, 144, 79),
    tit: 'ISI DANKORSENCHEY FC',
    location: 'AIA Stadium KMH Park',
    date: '22 Oct',
  ),
  EventModel(
    img:
        'https://upload.wikimedia.org/wikipedia/en/0/0b/Phnom_Penh_Crown_FC_Logo.png',
    color: Colors.red,
    tit: 'PHNOM PENH CROWN FC',
    location: 'Smart RSN Stadium',
    date: '21 Oct',
  ),
  EventModel(
    img:
        'https://upload.wikimedia.org/wikipedia/en/a/ab/Svay_Rieng_FC_logo.png',
    color: const Color.fromARGB(255, 14, 76, 245),
    tit: 'Preah Khan Reach Svay Rieng FC',
    location: 'Svay Rieng Stadium',
    date: '22 Oct',
  )
];
