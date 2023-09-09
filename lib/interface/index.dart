import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';

abstract class Web3AuthSDK {
  Future<void> init(ChainConfig config, Web3AuthOptions options,
      {WebOptions? webOptions});

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

enum UXMode {
  redirect,
  popup,
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

class MFAOption {
  final bool enable;
  final int priority;
  final bool mandatory;

  MFAOption({
    required this.enable,
    required this.priority,
    required this.mandatory,
  });
}

class MFASettings {
  MFAOption? deviceShareFactor;
  MFAOption? backUpShareFactor;
  MFAOption? socialBackupFactor;
  MFAOption? passwordFactor;
  MFASettings({
    this.deviceShareFactor,
    this.backUpShareFactor,
    this.socialBackupFactor,
    this.passwordFactor,
  });
}

class LoginSettings {
  MFALevel? mfaLevel;
  LoginSettings({
    this.mfaLevel,
  });
}

class WebOptions {
  MFASettings? mfaSettings;
  LoginSettings? loginSettings;
  UXMode? uxMode;
  WebOptions({this.mfaSettings, this.uxMode, this.loginSettings});
}
