import 'package:flutter/material.dart';

class WelcomeMessageWidget extends StatelessWidget {
  const WelcomeMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linearGradient = const LinearGradient(
      colors: <Color>[
        Color(0xFFF74C06),
        Color(0xFFCE7312),
        Color(0xFFF9CE23),
      ],
    ).createShader(const Rect.fromLTWH(0, 0, 300, 0));

    return Column(
      children: [
        Text(
          '🐓 Twitter Feed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Send me a tweet through the metaverse ✨',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '(By writing me a tweet there is a 10% chance to win 3 cents in Ether. '
          'It will be automatically transferred to your wallet if you win 🥳 '
          'Messages take about 15-20 seconds until displayed since this is the '
          'time the transaction is being mined and eventually included into a block. '
          'And you can only write every 60 seconds a message. I want to avoid getting spammed 👮 '
          'Nooooow have fun 👻)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
