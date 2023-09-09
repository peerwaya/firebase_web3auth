// ignore_for_file: constant_identifier_names, non_constant_identifier_names

@JS()

import 'package:js/js.dart';
import 'package:firebase_web3auth/web/web3_auth_web.dart';

@JS()
@anonymous
class SolanaPrivateKeyProviderOptions {
  external SolanaPrivKeyProviderConfig get config;
  external factory SolanaPrivateKeyProviderOptions({
    required SolanaPrivKeyProviderConfig config,
  });
}

@JS()
@anonymous
class SolanaPrivKeyProviderConfig {
  external ChainConfigWeb get chainConfig;
  external factory SolanaPrivKeyProviderConfig({
    required ChainConfigWeb chainConfig,
  });
}

@JS('SolanaProvider.SolanaPrivateKeyProvider')
class SolanaPrivateKeyProviderWeb {
  external factory SolanaPrivateKeyProviderWeb(
      SolanaPrivateKeyProviderOptions options);
}
