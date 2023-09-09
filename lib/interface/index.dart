import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';

abstract class Web3AuthSDK {
  Future<void> init(ChainConfig config, Web3AuthOptions options);

  Future<LoginResponse> login(LoginParams options);
}

class Web3AuthException implements Exception {
  final Web3AuthExceptionCode code;
  final String message;
  Web3AuthException({required this.code, required this.message});
}

enum Web3AuthExceptionCode {
  unknown,
  network,
  alreadyInitialized,
  notInitialized
}

class LoginResponse {
  final String? privKey;
  final String? ed25519PrivKey;
  final TorusUserInfo? userInfo;
  final String? error;

  LoginResponse({
    this.privKey,
    this.userInfo,
    this.ed25519PrivKey,
    this.error,
  });
}

class ChainConfig {
  final String chainNamespace;
  final String chainId;
  final String rpcTarget;
  final String displayName;
  final String blockExplorer;
  final String ticker;
  final String tickerName;

  ChainConfig({
    required this.chainNamespace,
    required this.chainId,
    required this.rpcTarget,
    required this.displayName,
    required this.blockExplorer,
    required this.ticker,
    required this.tickerName,
  });
}
