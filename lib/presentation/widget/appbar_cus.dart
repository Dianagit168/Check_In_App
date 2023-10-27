import 'package:check_in_app/index.dart';

PreferredSizeWidget normalAppBar(
  BuildContext context, 
  {
    required String? titleAppbar, 
    double fontSize = 23,
    bool isLeading = true
  }) {
  return AppBar(
    elevation: 0,
    automaticallyImplyLeading: isLeading,
    title: Text(
      titleAppbar!,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}