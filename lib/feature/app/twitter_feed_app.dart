import 'package:flutter/material.dart';
import 'package:web3_flutter/feature/home/home_page_widget.dart';

class TwitterFeedApp extends StatelessWidget {
  const TwitterFeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePageWidget(),
    );
  }
}
