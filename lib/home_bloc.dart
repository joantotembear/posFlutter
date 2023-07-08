import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_scan/core/utils/cancelable_completer.dart';

enum Status { initial, reading, confirmation, successfulPayment, processing }

class MainBLoC extends ChangeNotifier {
  bool isBackToEntryAmount = false;

  Status status = Status.initial;

  CancelableCompleter? completer;
  CancelableCompleter? completer2;

  String? tagData;

  final TextEditingController controller = TextEditingController();

  void confirmButton() async {
    status = Status.reading;
    notifyListeners();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        status = Status.confirmation;
        tagData = tag.data.toString();
        notifyListeners();
        NfcManager.instance.stopSession();
      },
      onError: (error) async {
        tagData = 'error';
      },
    );
  }

  void payButton() async {
    status = Status.processing;
    notifyListeners();
    completer2 = CancelableCompleter.auto(const Duration(seconds: 2));
    final result = await completer2!.future;
    if (result) {
      status = Status.successfulPayment;
      notifyListeners();
    } else {
      status = Status.confirmation;
      notifyListeners();
    }
  }

  void backToInitial() {
    status = Status.initial;
    notifyListeners();
  }

  void goConfirmation() {
    status = Status.confirmation;
    notifyListeners();
  }

  void cancelInReading() async {
    completer!.cancel();
  }

  void cancelProcessing() async {
    completer2!.cancel();
  }

  void clearController() {
    controller.clear();
    notifyListeners();
  }
}
