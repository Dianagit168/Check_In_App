import 'package:check_in_app/screen/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';

Future fetchUser(context, String username, String password) async {
  if (username.isNotEmpty && password.isNotEmpty) {
    http.Response response;
    response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      body: {
        'username': username, //kminchelle
        'password': password, //0lelplR
      },
    );
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScanQr(),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(14),
          contentPadding: const EdgeInsets.all(8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(LucideIcons.x),
                ),
              ),
              const Text('Please input email and password')
            ],
          ),
        );
      },
    );
  }
}
