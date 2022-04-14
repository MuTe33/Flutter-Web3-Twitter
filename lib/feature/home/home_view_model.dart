import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:web3_flutter/base/view_model.dart';
import 'package:web3_flutter/feature/home/home_repository.dart';
import 'package:web3_flutter/model/wave.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel(this._homeRepository);

  final HomeRepository _homeRepository;

  late final StreamSubscription? _mobileStreamSubscription;

  int _totalWaves = 0;
  List<Wave> _allWaves = [];
  String _hash = 'No tx hash available';

  int get totalWaves => _totalWaves;
  String get hash => _hash;

  List<Wave> get allWaves {
    return _allWaves
      ..sort(
        (a, b) => b.timestamp.compareTo(a.timestamp),
      );
  }

  Future<void> onInit() async {
    if (!kIsWeb) {
      // not supported for web
      _mobileStreamSubscription = _homeRepository
          .mobileWaveStream()
          .listen((_) async => await loadWaves());
    }

    await loadWaves();
  }

  Future<void> loadWaves() async {
    await Future.wait([
      _getTotalWaves(),
      _getAllWaves(),
    ]);
  }

  Future<void> sendWave({required String message}) async {
    setLoading();

    try {
      _hash = await _homeRepository.sendWave(message);
    } catch (e) {
      setError();
      return;
    }

    setIdle();
  }

  Future<void> _getTotalWaves() async {
    setLoading();

    _totalWaves = await _homeRepository.getTotalWaves();

    setIdle();
  }

  Future<void> _getAllWaves() async {
    setLoading();

    _allWaves = await _homeRepository.getAllWaves();

    setIdle();
  }

  @override
  void dispose() {
    _mobileStreamSubscription?.cancel();
    super.dispose();
  }
}
