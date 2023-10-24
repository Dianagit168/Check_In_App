
import 'dart:ui';
import 'package:check_in_app/index.dart';

class ModernDialog {
  
  dialogMessage(
    BuildContext context, 
    {Widget? title, 
    Widget? content, 
    Widget? action2,
    bool? removeFirstBtn,
    EdgeInsetsGeometry? edgeInsetsGeometry,
    bool? barrierDismissible
  }
  ) {

    return showDialog(
      barrierDismissible: barrierDismissible!,
      context: context,
      builder: (context) {

        return AlertDialog(
          title: title ?? Container(),
          // titlePadding: const EdgeInsets.all(20),
          titlePadding: edgeInsetsGeometry,
          content: content ?? Container(),
          contentPadding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          actions: [
            
            removeFirstBtn == false ? TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold))
            ) : Container(),

            action2 ?? Container()
          ],
        );
      }
    );
  }

  dialogLoading(BuildContext context, {bool? isTicket = false, String? content, bool barrierDismissible = false}) {

    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: _progress(isTicket: isTicket!, content: content)
        );
      }
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
                )
              ),

              if (content == null)
              Container()
              else
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

  Future<Widget> successMsg(BuildContext context, String msg, {String? animtaion, Widget? action2, bool barrierDismissible = true}) async{
    return await dialogMessage(
      context, 
      title: Lottie.asset(
        animtaion ?? "assets/animations/successful.json",
        repeat: true,
        reverse: true,
        height: 80
      ), 
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500
        ),
        textAlign: TextAlign.center,
      ),
      action2: action2,
      removeFirstBtn: true,
      barrierDismissible: barrierDismissible
    ) ?? Container();
  }

  Future<Widget> errorMsg(BuildContext context, String error, {String? animtaion, Widget? action2, bool barrierDismissible = true}) async {
    return await dialogMessage(
      context, 
      title: Lottie.asset(
        animtaion ?? "assets/animations/failed.json",
        repeat: true,
        reverse: true,
        height: 80
      ),
      content: Text(
        error,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500
        ),
        textAlign: TextAlign.center,
      ),
      action2: action2,
      removeFirstBtn: true,
      barrierDismissible: barrierDismissible
    ) ?? Container();
  }
}