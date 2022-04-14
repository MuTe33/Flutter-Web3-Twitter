// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"inputs":[],"stateMutability":"payable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":false,"internalType":"string","name":"message","type":"string"},{"indexed":false,"internalType":"uint256","name":"timestamp","type":"uint256"}],"name":"NewTweet","type":"event"},{"inputs":[],"name":"getAllTweets","outputs":[{"components":[{"internalType":"address","name":"from","type":"address"},{"internalType":"string","name":"message","type":"string"},{"internalType":"uint256","name":"timestamp","type":"uint256"}],"internalType":"struct TwitterFeed.Tweet[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getTotalTweets","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"lastTweetedAt","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_message","type":"string"}],"name":"tweet","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
    'TwitterFeed');

class TwitterFeed extends _i1.GeneratedContract {
  TwitterFeed(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<dynamic>> getAllTweets({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '53256135'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getTotalTweets({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '93f11c27'));
    final params = [];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> lastTweetedAt(_i1.EthereumAddress $param0,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'b281395b'));
    final params = [$param0];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> tweet(String _message,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, 'fb46d4c5'));
    final params = [_message];
    return write(credentials, transaction, function, params);
  }

  /// Returns a live stream of all NewTweet events emitted by this contract.
  Stream<NewTweet> newTweetEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('NewTweet');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return NewTweet(decoded);
    });
  }
}

class NewTweet {
  NewTweet(List<dynamic> response)
      : from = (response[0] as _i1.EthereumAddress),
        message = (response[1] as String),
        timestamp = (response[2] as BigInt);

  final _i1.EthereumAddress from;

  final String message;

  final BigInt timestamp;
}
