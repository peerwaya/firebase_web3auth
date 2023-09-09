import 'package:firebase_web3auth/interface/index.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Web3AuthSDKNative extends Web3AuthSDK {
  Web3AuthSDKNative._();

  static Web3AuthSDKNative instance = Web3AuthSDKNative._();

  @override
  Future<void> init(ChainConfig config, Web3AuthOptions options) async {
    try {
      await Web3AuthFlutter.init(options);
    } catch (error) {
      print("Error: $error");
      throw Web3AuthException(
          code: Web3AuthExceptionCode.unknown, message: '$error');
    }
  }

  @override
  Future<LoginResponse> login(LoginParams options) async {
    try {
      final response = await Web3AuthFlutter.login(options);
      return LoginResponse(
        privKey: response.privKey,
        ed25519PrivKey: response.ed25519PrivKey,
        userInfo: response.userInfo,
      );
    } catch (error) {
      print("Error: $error");
      throw Web3AuthException(
          code: Web3AuthExceptionCode.unknown, message: '$error');
    }
  }
}
