import 'package:firebase_web3auth/interface/index.dart';
import 'package:firebase_web3auth/native/web3auth.dart';

Web3AuthSDK web3AuthSDK() {
  return Web3AuthSDKNative.instance;
}
