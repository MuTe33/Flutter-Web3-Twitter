import 'package:flutter/material.dart';
import 'package:web3_wave_portal/feature/home/home_page_widget.dart';

class WavePortalApp extends StatelessWidget {
  const WavePortalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePageWidget(),
    );
  }
}
