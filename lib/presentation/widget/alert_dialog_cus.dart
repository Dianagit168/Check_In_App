import 'dart:ui';
import 'package:check_in_app/index.dart';

class ModernDialog {
  Future<void> dialogMessage(
      BuildContext context, {
        Widget? title,
        Widget? content,
        Widget? action2,
        bool removeFirstBtn = false,
        EdgeInsetsGeometry? edgeInsetsGeometry,
        bool barrierDismissible = true,
      }) async {
    await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title ?? Container(),
          titlePadding: edgeInsetsGeometry,
          content: content ?? Container(),
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: [
            if (!removeFirstBtn)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            action2 ?? Container(),
          ],
        );
      },
    );
  }

  Future<void> dialogLoading(
      BuildContext context, {
        bool isTicket = false,
        String? content,
        bool barrierDismissible = false,
      }) async {
    await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: _progress(isTicket: isTicket, content: content),
        );
      },
    );
  }

  Widget _progress({bool isTicket = false, String? content}) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(
                  Color.fromRGBO(130, 102, 224, 1),
                ),
              ),
              if (content != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 16.0),
                  child: Text(content, textAlign: TextAlign.center),
                ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> successMsg(
      BuildContext context, String msg, {
        String? animation,
        Widget? action2,
        bool barrierDismissible = true,
      }) async {
    await dialogMessage(
      context,
      title: Lottie.asset(
        animation ?? "assets/animations/successful.json",
        repeat: true,
        reverse: true,
        height: 80,
      ),
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      action2: action2,
      removeFirstBtn: true,
      barrierDismissible: barrierDismissible,
    );
  }

  Future<void> errorMsg(
      BuildContext context, String error, {
        String? animation,
        Widget? action2,
        bool barrierDismissible = true,
      }) async {
    await dialogMessage(
      context,
      title: Lottie.asset(
        animation ?? "assets/animations/failed.json",
        repeat: true,
        reverse: true,
        height: 80,
      ),
      content: Text(
        error,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      action2: action2,
      removeFirstBtn: true,
      barrierDismissible: barrierDismissible,
    );
  }
}
