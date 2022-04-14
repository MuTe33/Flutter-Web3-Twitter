import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:web3_flutter/base/view_model.dart';
import 'package:web3_flutter/feature/home/home_repository.dart';
import 'package:web3_flutter/model/tweet.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel(this._homeRepository);

  final HomeRepository _homeRepository;

  late final StreamSubscription? _mobileStreamSubscription;

  int _totalWaves = 0;
  List<Tweet> _allWaves = [];
  String _hash = 'No tx hash available';

  int get totalWaves => _totalWaves;
  String get hash => _hash;

  List<Tweet> get allWaves {
    return _allWaves
      ..sort(
        (a, b) => b.timestamp.compareTo(a.timestamp),
      );
  }

  Future<void> onInit() async {
    if (!kIsWeb) {
      // not supported for web
      _mobileStreamSubscription =
          _homeRepository.tweetStream().listen((_) async => await loadWaves());
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
      _hash = await _homeRepository.tweet(message);
    } catch (e) {
      setError();
      return;
    }

    setIdle();
  }

  Future<void> _getTotalWaves() async {
    setLoading();

    _totalWaves = await _homeRepository.getTotalTweets();

    setIdle();
  }

  Future<void> _getAllWaves() async {
    setLoading();

    _allWaves = await _homeRepository.getAllTweets();

    setIdle();
  }

  @override
  void dispose() {
    _mobileStreamSubscription?.cancel();
    super.dispose();
  }
}
