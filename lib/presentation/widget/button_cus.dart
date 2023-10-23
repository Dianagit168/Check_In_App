import 'package:check_in_app/index.dart';

class ElevatedButtonCust extends StatelessWidget {
  const ElevatedButtonCust({
    Key? key,
    this.tit,
    this.onNavigator,
    this.btnHigh,
  }) : super(key: key);
  final String? tit;
  final double? btnHigh;
  final void Function()? onNavigator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHigh,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: const Color.fromARGB(255, 37, 67, 148),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width, btnHigh!),
          elevation: 0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(16),
          // ),
        ),
        onPressed: onNavigator,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LucideIcons.logIn,
              color: Color.fromARGB(255, 37, 67, 148),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              tit!,
              style: const TextStyle(
                color: Color.fromARGB(255, 37, 67, 148),
                fontSize:17
              ),
            ),
          ],
        ),
      ),
    );
  }
}
