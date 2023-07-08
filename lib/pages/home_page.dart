import 'package:flutter/material.dart';
import 'package:nfc_scan/home_bloc.dart';
import 'package:nfc_scan/pages/nfc_scan/ncf_scan_page.dart';
import 'package:nfc_scan/pages/pso_offline/pso_offline_page.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NFCScanPage())),
            child: Image.asset(
              'assets/quantic_icon.jpg',
              height: 100,
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider(create: (context) => MainBLoC(), child: const PSOOffline()))),
              child: const Text(
                'REALIZAR PAGO',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
