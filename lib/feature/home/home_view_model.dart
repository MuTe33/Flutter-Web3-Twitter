import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web3_wave_portal/base/view_model.dart';
import 'package:web3_wave_portal/feature/home/home_repository.dart';
import 'package:web3_wave_portal/model/wave.dart';

const rinkebyChainId = 4;

class HomeViewModel extends ViewModel {
  HomeViewModel(this._homeRepository);

  final HomeRepository _homeRepository;

  late final StreamSubscription? _mobileStreamSubscription;
  late final Web3Provider? _web3Provider;
  late final BehaviorSubject? _webWaveStream;

  String _currentAddress = '';
  int _currentChain = -1;
  int _totalWaves = 0;
  List<Wave> _allWaves = [];
  String _hash = 'No tx hash available';

  bool get _isInOperatingChain => _currentChain == rinkebyChainId;
  bool get _isConnected => isEnabled && _currentAddress.isNotEmpty;

  bool get isWalletConnectReady => _isConnected && _isInOperatingChain;
  bool get isEnabled => ethereum != null;
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
      _hash = await _homeRepository.sendWave(
        message,
        _web3Provider,
      );
    } catch (e) {
      setError();
      return;
    }

    setIdle();
  }

  Future<void> onConnectClicked() async {
    if (isEnabled) {
      final accounts = await ethereum!.requestAccount();

      if (accounts.isNotEmpty) {
        _currentAddress = accounts.first;
        _currentChain = await ethereum!.getChainId();

        _web3Provider = Web3Provider.fromEthereum(ethereum!);

        _initWebStream();
      }

      update();
    }
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

  void _initWebStream() {
    _homeRepository.initWebWaveStream(_web3Provider!);

    _webWaveStream = _homeRepository.webWaveStream;

    _webWaveStream!.listen((_) => loadWaves());
  }

  @override
  void dispose() {
    _mobileStreamSubscription?.cancel();
    _webWaveStream?.close();
    super.dispose();
  }
}
