import 'package:flutter/material.dart';

class NotSupportedMessageWidget extends StatelessWidget {
  const NotSupportedMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Please use a Web3 supported browser or reload your wallet 🔥',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          foreground: Paint()
            ..shader = const LinearGradient(
              colors: <Color>[
                Color(0xFFF74C06),
                Color(0xFFCE7312),
                Color(0xFFF9CE23),
              ],
            ).createShader(const Rect.fromLTWH(0, 0, 1000, 0)),
        ),
      ),
    );
  }
}
