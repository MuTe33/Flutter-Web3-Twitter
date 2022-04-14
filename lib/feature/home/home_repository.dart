import 'dart:async';

import 'package:web3_flutter/contract/TwitterFeed.g.dart';
import 'package:web3_flutter/model/tweet.dart';
import 'package:web3dart/web3dart.dart';

class HomeRepository {
  HomeRepository(this._contract);

  final TwitterFeed _contract;

  Future<int> getTotalTweets() async {
    final result = await _contract.getTotalTweets();

    return result.toInt();
  }

  Future<List<Tweet>> getAllTweets() async {
    final result = await _contract.getAllTweets();

    final parsedTweets = result
        .map(
          (tweet) => Tweet(
            address: tweet[0],
            message: tweet[1],
            timestamp: tweet[2],
          ),
        )
        .toList();

    return parsedTweets;
  }

  Future<String> tweet(String message) async {
    final credentials = EthPrivateKey.fromHex('<YOUR_PRIVATE_KEY>');

    return _contract.tweet(message, credentials: credentials);
  }

  Stream<NewTweet> tweetStream() {
    return _contract.newTweetEvents();
  }
}
