import 'dart:async';

import 'package:web3_flutter/model/wave.dart';
import 'package:web3dart/web3dart.dart';

class HomeRepository {
  HomeRepository(
    this._client,
    this._deployedContract,
  );

  final Web3Client _client;
  final DeployedContract _deployedContract;

  Future<int> getTotalWaves() async {
    final result = await _callContract('getTotalWaves', []);

    final parsedResult = result[0] as BigInt;

    return parsedResult.toInt();
  }

  Future<List<Wave>> getAllWaves() async {
    final result = await _callContract('getAllWaves', []);

    final formatResult = result[0] as List<dynamic>;

    return formatResult
        .map(
          (wave) => Wave(
            address: wave[0],
            message: wave[1],
            timestamp: wave[2],
          ),
        )
        .toList();
  }

  Future<String> sendWave(String message) async {
    return _sendTransaction('wave', [message]);
  }

  Stream<FilterEvent> mobileWaveStream() {
    return _client.events(
      FilterOptions.events(
        contract: _deployedContract,
        event: _contractEvent,
      ),
    );
  }

  Future<List<dynamic>> _callContract(
    String functionName,
    List<dynamic> args,
  ) {
    final function = _deployedContract.function(functionName);

    return _client.call(
      contract: _deployedContract,
      function: function,
      params: args,
    );
  }

  Future<String> _sendTransaction(
    String functionName,
    List<dynamic> args,
  ) async {
    // for mobile we currently use the private key directly here
    // wallet connect implementation is quite different to web
    // this will be changed at some time to implement wallet connect
    // but for now this is okay since we do not publish :)
    final privateKey = EthPrivateKey.fromHex('<YOUR_PRIVATE_KEY>');

    final function = _deployedContract.function(functionName);

    return _client.sendTransaction(
      privateKey,
      Transaction.callContract(
        contract: _deployedContract,
        function: function,
        parameters: args,
      ),
      // rinkeby chain id
      chainId: 4,
    );
  }

  // Event definiton from ABI, needed for web3dart package to identify the NewWave event
  ContractEvent get _contractEvent {
    return ContractEvent(
      false,
      "NewWave",
      <EventComponent>[
        const EventComponent(
          FunctionParameter(
            'from',
            AddressType(),
          ),
          true,
        ),
        const EventComponent(
          FunctionParameter(
            'message',
            StringType(),
          ),
          false,
        ),
        const EventComponent(
          FunctionParameter(
            'timestamp',
            UintType(),
          ),
          false,
        ),
      ],
    );
  }
}
