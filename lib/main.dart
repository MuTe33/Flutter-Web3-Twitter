import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web3_flutter/feature/app/twitter_feed_app.dart';
import 'package:web3_flutter/locator.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details, forceReport: true);
      };

      initSyncDependencies();

      runApp(const TwitterFeedApp());
    },
    (e, s) => FlutterError.reportError(
      FlutterErrorDetails(exception: e, stack: s),
    ),
  );
}
