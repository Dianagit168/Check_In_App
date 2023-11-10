  import 'package:check_in_app/index.dart';

Widget textfieldWidget(
    BuildContext context,
    final Icon? icon,
    final String title,
    final TextEditingController? controller,
    
    {
      final bool? isSecure,
      final Function? toggleObscured,
    }
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: icon!,
              suffixIcon:  Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: GestureDetector(
                  onTap: toggleObscured!(),
                  child: Icon(
                    isSecure!
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                    size: 24,
                  ),
                ),
              ),
            ),
            controller: controller,
            obscureText: isSecure,
          ),
        ),
      ],
    );
  }
  