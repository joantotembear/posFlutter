import 'package:flutter/material.dart';
import 'package:nfc_scan/home_bloc.dart';
import 'package:provider/provider.dart';

class EnterAmount extends StatefulWidget {
  const EnterAmount({
    Key? key,
    required this.blueColor,
    required this.onTap,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  final Color blueColor;
  final GlobalKey<FormState> formKey;
  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  State<EnterAmount> createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainBLoC>();
    return Stack(
      children: [
        Form(
          key: widget.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    const Text('Monto'),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: bloc.controller,
                          decoration: InputDecoration(
                            hintText: 'Placeholder value',
                            hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value!.isEmpty) return 'Por favor ingrese un monto';
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Text(
              'Confirmar',
              style: TextStyle(color: widget.blueColor, fontSize: 17),
            ),
          ),
        )
      ],
    );
  }
}
