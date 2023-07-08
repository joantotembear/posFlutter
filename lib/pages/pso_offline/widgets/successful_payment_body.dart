import 'package:flutter/material.dart';
import 'package:nfc_scan/home_bloc.dart';
import 'package:nfc_scan/pages/pso_offline/widgets/confirmation_body.dart';
import 'package:provider/provider.dart';

class SuccessfulPayment extends StatelessWidget {
  const SuccessfulPayment({
    Key? key,
    required this.size,
    required this.status,
    required this.blueColor,
    required this.onTap,
    required this.monto,
  }) : super(key: key);

  final Size size;
  final ValueNotifier<String> status;
  final Color blueColor;
  final VoidCallback onTap;
  final String monto;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            children: [
              LabelAndValue(
                label: 'Monto',
                value: 'USD $monto',
              ),
              Consumer<MainBLoC>(
                builder: (context, bloc, child) => LabelAndValue(
                  label: 'Billetera',
                  value: bloc.tagData!,
                ),
              ),
              const LabelAndValue(
                label: 'Firma digital',
                value: 'adfad21f41nf1ecc984',
              ),
              const LabelAndValue(
                label: 'Status',
                value: 'Procesado',
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(top: 0.0, left: 16, right: 16),
            height: size.height * 0.08,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Volver',
                    style: TextStyle(color: blueColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
