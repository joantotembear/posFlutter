import 'package:flutter/material.dart';
import 'package:nfc_scan/home_bloc.dart';
import 'package:provider/provider.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({
    Key? key,
    required this.size,
    required this.status,
    required this.blueColor,
    required this.monto,
  }) : super(key: key);

  final Size size;
  final ValueNotifier<String> status;
  final Color blueColor;
  final String monto;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBLoC>();
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
                builder: (context, blocc, child) => LabelAndValue(
                  label: 'Billetera',
                  value: bloc.tagData!,
                ),
              ),
              const LabelAndValue(
                label: 'Firma digital',
                value: 'adfad21f41nf1ecc984',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => bloc.backToInitial(),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: blueColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () => bloc.payButton(),
                  child: Text(
                    'Pagar',
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

class LabelAndValue extends StatelessWidget {
  final String label;
  final String value;

  const LabelAndValue({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            const SizedBox(width: 35.0),
            Flexible(
              child: Text(
                value,
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        const Divider()
      ],
    );
  }
}
