import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScanPage extends StatefulWidget {
  const NFCScanPage({Key? key}) : super(key: key);

  @override
  State<NFCScanPage> createState() => _NFCScanPageState();
}

class _NFCScanPageState extends State<NFCScanPage> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  ValueNotifier<String> status = ValueNotifier('initial');

  final color = Color(0XFF01295C);
  final style = TextStyle(color: Color(0XFF01295C), fontSize: 70, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + size.height * 0.07, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Image.asset('assets/quantic_icon.jpg'),
                  const SizedBox(height: 30),
                  Text(
                    'P.O.S',
                    style: style,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                  valueListenable: status,
                  builder: (context, value, child) {
                    if (value == 'initial') {
                      return Align(
                        alignment: const Alignment(0, -.4),
                        child: GestureDetector(
                          onTap: _tagRead,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: color, width: 3),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              'NFC',
                              style: style,
                            ),
                          ),
                        ),
                      );
                    } else if (value == 'reading') {
                      return Align(
                        alignment: const Alignment(0, -.4),
                        child: Text(
                          'Leyendo...',
                          style: style,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (value == 'finished') {
                      return Column(
                        children: [
                          ValueListenableBuilder<dynamic>(
                            valueListenable: result,
                            builder: (context, value, _) => Expanded(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                '${value ?? ''}',
                                style: style.copyWith(fontSize: 20),
                              ),
                            )),
                          ),
                          GestureDetector(
                            onTap: _sendSMS,
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: color, width: 2),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                'Enviar',
                                style: style.copyWith(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: size.height * 0.1,
                            color: Colors.green,
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          ValueListenableBuilder<dynamic>(
                            valueListenable: result,
                            builder: (context, value, _) => Expanded(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                'ERROR DE\nLECTURA',
                                style: style.copyWith(fontSize: 70),
                              ),
                            )),
                          ),
                          GestureDetector(
                            onTap: () {
                              status.value = 'initial';
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: color, width: 2),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                'Volver',
                                style: style.copyWith(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: size.height * 0.1,
                            color: Colors.red,
                          )
                        ],
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _sendSMS() async {
    String _result = await sendSMS(
      message: result.value.toString(),
      recipients: ['66176441', '+50766176441'],
    ).catchError((onError) async {
      print(onError);
      status.value = 'initial';
      result.value = '';
    });
    status.value = 'initial';
    result.value = '';
    print(_result);
  }

  void _tagRead() {
    status.value = 'reading';
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        status.value = 'finished';
        result.value = tag.data;

        NfcManager.instance.stopSession();
      },
      onError: (error) async {
        status.value = 'error';
      },
    );
  }
}
