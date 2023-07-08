import 'package:flutter/material.dart';
import 'package:nfc_scan/pages/home_page.dart';
import 'package:nfc_scan/pages/nfc_scan/ncf_scan_page.dart';
import 'package:nfc_scan/pages/pso_offline/pso_offline_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
