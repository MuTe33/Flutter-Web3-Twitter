import 'package:web3_flutter/util/date_time_util.dart';
import 'package:web3dart/web3dart.dart';

class Wave {
  Wave({
    required this.address,
    required this.message,
    required this.timestamp,
  });

  final EthereumAddress address;
  final String message;
  final BigInt timestamp;

  String get formattedTimeStamp {
    return formatTime(
      timestamp.toInt() * 1000,
      pastSuffix: 'ago',
      futureSuffix: 'soon',
    );
  }

  String get formattedAddress {
    return address.hex.substring(0, 10);
  }

  @override
  String toString() {
    return 'Wave{address: $address, message: $message, timestamp: $timestamp}';
  }
}
