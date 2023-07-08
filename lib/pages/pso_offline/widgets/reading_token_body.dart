import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadingToken extends StatefulWidget {
  const ReadingToken({
    Key? key,
    required this.size,
    required this.blueColor,
    required this.cancelOnTap,
    required this.status,
    this.isCommingBack = false,
  }) : super(key: key);

  final Size size;
  final Color blueColor;
  final VoidCallback cancelOnTap;
  final ValueNotifier<String> status;
  final bool? isCommingBack;

  @override
  State<ReadingToken> createState() => _ReadingTokenState();
}

class _ReadingTokenState extends State<ReadingToken> {
  late bool isBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CupertinoActivityIndicator(),
                SizedBox(width: 5.0),
                Text(
                  'Leyendo token',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(top: 10.0),
            height: widget.size.height * 0.08,
            width: widget.size.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: GestureDetector(
              onTap: widget.cancelOnTap,
              child: Text(
                'Cancelar',
                style: TextStyle(color: widget.blueColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
