import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:web3_wave_portal/contract/wave_portal_abi.dart';
import 'package:web3_wave_portal/feature/home/home_repository.dart';
import 'package:web3_wave_portal/feature/home/home_view_model.dart';
import 'package:web3_wave_portal/model/contract_config.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

GetIt locator = GetIt.instance;
GetIt _l = locator;

Future<void> resetDependencies() async {
  await _l.reset();
}

void initSyncDependencies() {
  _initContractConfig();
  _initNetworking();
  _initDeployedContract();
  _l.registerSingleton(HomeRepository(_l.get(), _l.get(), _l.get()));
  _l.registerSingleton(HomeViewModel(_l.get()));
}

void _initContractConfig() {
  final contractConfig = ContractConfig(
    '0x02b6E4bb701d702517f51546a4902f86A4BD8fAc',
    wavePortalAbi,
    'WavePortal',
  );

  _l.registerSingleton(contractConfig);
}

void _initNetworking() {
  const rinkebyAlchemyUrl =
      'https://eth-rinkeby.alchemyapi.io/v2/<YOUR_API_KEY>';
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

void _initDeployedContract() {
  final contractConfig = _l.get<ContractConfig>();

  final deployedContract = DeployedContract(
    ContractAbi.fromJson(
      contractConfig.wavePortalAbi,
      contractConfig.contractName,
    ),
    EthereumAddress.fromHex(contractConfig.wavePortalContractAddress),
  );

  _l.registerSingleton(deployedContract);
}
