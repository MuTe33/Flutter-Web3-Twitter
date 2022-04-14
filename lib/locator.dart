import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:web3_flutter/contract/TwitterFeed.g.dart';
import 'package:web3_flutter/feature/home/home_repository.dart';
import 'package:web3_flutter/feature/home/home_view_model.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

GetIt locator = GetIt.instance;
GetIt _l = locator;

Future<void> resetDependencies() async {
  await _l.reset();
}

void initSyncDependencies() {
  _initNetworking();
  _initContract();
  _l.registerSingleton(HomeRepository(_l.get()));
  _l.registerSingleton(HomeViewModel(_l.get()));
}

void _initNetworking() {
  // access to the Ethereum blockchain
  const rinkebyAlchemyUrl =
      'https://eth-rinkeby.alchemyapi.io/v2/<YOUR_API_KEY>';

  // needed for streams/events
  const rinkebyAlchemyWss = 'wss://eth-rinkeby.alchemyapi.io/v2/<YOUR_API_KEY>';

  final client = Web3Client(
    rinkebyAlchemyUrl,
    Client(),
    socketConnector: () {
      return IOWebSocketChannel.connect(rinkebyAlchemyWss).cast<String>();
    },
  );

  _l.registerSingleton(client);
}

void _initContract() {
  final client = _l.get<Web3Client>();

  final contract = TwitterFeed(
    // smart contract address
    address: EthereumAddress.fromHex(
      '0xB8262097D5a743Fa297DC31A50E83F951A7F430E',
    ),
    client: client,
    // rinkeby test network chainId
    chainId: 4,
  );

  _l.registerSingleton(contract);
}
