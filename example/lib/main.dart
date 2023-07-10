import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:simple_mobile_auth/simple_mobile_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MobileResult _mobileResult = MobileResult.unavailable;
  final _simpleMobileAuthPlugin = SimpleMobileAuthService();

  @override
  void initState() {
    super.initState();
  }

  Future<void> requestAuth() async {
    MobileResult mobileResult;
    try {
      final content = MobileAuthContent(
          iosSubTitle: "Toque no sensor para se autenticar",
          androidTitle: "Simple Auth",
          negativeButtonText: "Cancelar",
          androidSubTitle: "Toque no sensor para se autenticar");
      mobileResult =
          await _simpleMobileAuthPlugin.biometricAuthentication(content);
      print("RESULT : ${mobileResult.name}");
    } on PlatformException {
      mobileResult = MobileResult.failed;
    }
    if (!mounted) return;

    setState(() {
      _mobileResult = mobileResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Simple Mobile Auth'),
        ),
        body: Center(
          child: Text(
            _mobileResult.name,
            style: TextStyle(
                color: _mobileResult == MobileResult.success
                    ? Colors.green
                    : Colors.red,
                fontSize: 50.0),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(_mobileResult == MobileResult.success
              ? Icons.lock_open_sharp
              : Icons.lock),
          onPressed: () => requestAuth(),
        ),
      ),
    );
  }
}
