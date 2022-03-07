import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web3_wave_portal/feature/app/wave_portal_app.dart';
import 'package:web3_wave_portal/locator.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details, forceReport: true);
      };

      initSyncDependencies();

      runApp(const WavePortalApp());
    },
    (e, s) => FlutterError.reportError(
      FlutterErrorDetails(exception: e, stack: s),
    ),
  );
}
