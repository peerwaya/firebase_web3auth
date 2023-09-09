import 'package:firebase_web3auth/interface/index.dart';
import 'package:web3auth_flutter/input.dart';

class Web3AuthSDKUnsupported extends Web3AuthSDK {
  Web3AuthSDKUnsupported._();

  static Web3AuthSDKUnsupported instance = Web3AuthSDKUnsupported._();

  @override
  Future<void> init(ChainConfig config, Web3AuthOptions options) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> login(LoginParams options) {
    // TODO: implement login
    throw UnimplementedError();
  }
}

Web3AuthSDK web3AuthSDK() {
  throw UnimplementedError();
}
