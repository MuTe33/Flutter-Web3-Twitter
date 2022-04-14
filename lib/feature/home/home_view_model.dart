import 'dart:async';

import 'package:web3_flutter/base/view_model.dart';
import 'package:web3_flutter/feature/home/home_repository.dart';
import 'package:web3_flutter/model/tweet.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel(this._homeRepository);

  final HomeRepository _homeRepository;

  late final StreamSubscription _tweetStreamSubscription;

  int _totalTweets = 0;
  List<Tweet> _allTweets = [];
  String _hash = 'No tx hash available';

  int get totalTweets => _totalTweets;
  String get hash => _hash;

  List<Tweet> get allTweets {
    return _allTweets
      ..sort(
        (a, b) => b.timestamp.compareTo(a.timestamp),
      );
  }

  Future<void> onInit() async {
    _tweetStreamSubscription = _homeRepository.tweetStream().listen((_) async {
      await _loadTweets();
    });

    await _loadTweets();
  }

  Future<void> sendTweet({required String message}) async {
    setLoading();

    try {
      _hash = await _homeRepository.tweet(message);
    } catch (e) {
      setError();
      return;
    }

    setIdle();
  }

  Future<void> _loadTweets() async {
    await Future.wait([
      _getTotalTweets(),
      _getAllTweets(),
    ]);
  }

  Future<void> _getTotalTweets() async {
    setLoading();

    _totalTweets = await _homeRepository.getTotalTweets();

    setIdle();
  }

  Future<void> _getAllTweets() async {
    setLoading();

    _allTweets = await _homeRepository.getAllTweets();

    setIdle();
  }

  @override
  void dispose() {
    _tweetStreamSubscription.cancel();
    super.dispose();
  }
}
