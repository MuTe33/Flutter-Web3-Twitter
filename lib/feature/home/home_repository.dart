import 'dart:async';

import 'package:web3_flutter/contract/TwitterFeed.g.dart';
import 'package:web3_flutter/model/tweet.dart';
import 'package:web3dart/web3dart.dart';

class HomeRepository {
  HomeRepository(
    this._client,
    this._contract,
  );

  final Web3Client _client;
  final TwitterFeed _contract;

  Future<int> getTotalTweets() async {
    final result = await _contract.getTotalTweets();

    return result.toInt();
  }

  Future<List<Tweet>> getAllTweets() async {
    final result = await _contract.getAllTweets();

    return result as List<Tweet>;
  }

  Future<String> tweet(String message) async {
    final credentials = EthPrivateKey.fromHex('<YOUR_PRIVATE_KEY>');

    return _contract.tweet(message, credentials: credentials);
  }

  Stream<NewTweet> tweetStream() {
    return _contract.newTweetEvents();
  }
}
