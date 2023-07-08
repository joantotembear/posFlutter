import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nfc_scan/home_bloc.dart';
import 'package:nfc_scan/pages/pso_offline/widgets/confirmation_body.dart';
import 'package:nfc_scan/pages/pso_offline/widgets/enter_amount_body.dart';
import 'package:nfc_scan/pages/pso_offline/widgets/processing_body.dart';
import 'package:nfc_scan/pages/pso_offline/widgets/reading_token_body.dart';
import 'package:nfc_scan/pages/pso_offline/widgets/successful_payment_body.dart';
import 'package:provider/provider.dart';

class PSOOffline extends StatefulWidget {
  const PSOOffline({Key? key}) : super(key: key);

  @override
  State<PSOOffline> createState() => _PSOOfflineState();
}

class _PSOOfflineState extends State<PSOOffline> {
  ValueNotifier<String> status = ValueNotifier('initial');
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  bool _isCommingBackFromConfirmation = false;
  bool _isCommingBackFromProcessing = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final style = TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
    final blueColor = Color(0XFF007AFF);
    final bloc = context.read<MainBLoC>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.1,
        elevation: 1,
        backgroundColor: Colors.grey[200],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 13,
                      decoration: BoxDecoration(border: Border.all(color: blueColor)),
                    ),
                    const SizedBox(width: 3.0),
                    Consumer<MainBLoC>(
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            value.status == Status.initial
                                ? Navigator.of(context).pop()
                                : value.status == Status.reading || value.status == Status.confirmation
                                    ? bloc.backToInitial()
                                    : bloc.goConfirmation();
                          },
                          child: Text(
                            value.status == Status.initial
                                ? 'Salir'
                                : value.status == Status.reading
                                    ? 'Ingrese monto'
                                    : value.status == Status.confirmation
                                        ? 'Ingrese monto'
                                        : value.status == Status.processing
                                            ? 'Confirmación'
                                            : 'Confirmación',
                            style: const TextStyle(color: Color(0XFF007AFF), fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Text(
                      'PSO',
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            Align(
                alignment: Alignment.centerLeft,
                child: Consumer<MainBLoC>(
                  builder: (context, value, child) => Text(
                    value.status == Status.initial
                        ? 'Ingrese monto'
                        : value.status == Status.reading
                            ? 'Leyendo'
                            : value.status == Status.confirmation
                                ? 'Confirmación '
                                : value.status == Status.processing
                                    ? 'Procesando'
                                    : 'Pago exitoso',
                    style: style,
                  ),
                )),
          ],
        ),
      ),
      body: Consumer<MainBLoC>(
        builder: (context, value, child) {
          if (value.status == Status.initial) {
            return EnterAmount(
              controller: bloc.controller,
              blueColor: blueColor,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  bloc.confirmButton();
                }
              },
              formKey: _formKey,
            );
          } else if (value.status == Status.reading) {
            return ReadingToken(
              size: size,
              status: status,
              blueColor: blueColor,
              cancelOnTap: () => bloc.backToInitial(),
              isCommingBack: _isCommingBackFromConfirmation,
            );
          } else if (value.status == Status.confirmation) {
            return Confirmation(
              size: size,
              status: status,
              blueColor: blueColor,
              monto: bloc.controller.text,
            );
          } else if (value.status == Status.processing) {
            return Processing(
              size: size,
              status: status,
              blueColor: blueColor,
              cancelOnTap: () => bloc.cancelProcessing(),
              isCommingBack: _isCommingBackFromProcessing,
            );
          } else if (value.status == Status.successfulPayment) {
            return SuccessfulPayment(
              size: size,
              status: status,
              blueColor: blueColor,
              onTap: () {
                bloc.clearController();
                bloc.backToInitial();
              },
              monto: bloc.controller.text,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
