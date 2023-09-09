// ignore_for_file: constant_identifier_names, non_constant_identifier_names

@JS()
library firebase_web3auth;

import 'package:js/js.dart';
import 'package:web3auth_flutter/enums.dart';

@JS('window.web3AuthProviderRequest')
external T? web3AuthProviderRequest<T>(dynamic provider, String method);

enum ChainNameSpaces { eip155, solana, other }

enum AuthMode { DAPP, WALLET }

enum WalletAdapters {
  openlogin,
}

@JS()
@anonymous
class ChainConfigWeb {
  external ChainNameSpaces get chainNamespace;
  external String get chainId;
  external String get rpcTarget;
  external String get displayName;
  external String get blockExplorer;
  external String get ticker;
  external String get tickerName;
  external factory ChainConfigWeb({
    String chainNamespace,
    String chainId,
    String rpcTarget,
    String displayName,
    String blockExplorer,
    String ticker,
    String tickerName,
  });
}

@JS()
@anonymous
class Web3AuthNoModalOptions {
  external ChainConfigWeb get chainConfig;
  external String get clientId;
  external bool? get enableLogging;
  external factory Web3AuthNoModalOptions({
    required ChainConfigWeb chainConfig,
    required String clientId,
    bool? enableLogging,
  });
}

@JS('NoModal.Web3AuthNoModal')
class Web3AuthNoModalWeb {
  external ChainConfigWeb get chainConfig;
  external String get clientId;
  external bool get enableLogging;
  external dynamic get provider;

  external factory Web3AuthNoModalWeb(Web3AuthNoModalOptions options);
  external Future<void> init();
  external void configureAdapter(OpenloginAdapterJs adapter);
  external ProviderJs connectTo(String adapter, LoginParamsJs params);
  external Future<UserAuthInfo> authenticateUser();
  external Future<UserInfo> getUserInfo();
  external Future<void> logout(LogoutOptions option);
}

@JS()
@anonymous
class LoginParamsJs {
  external Provider get loginProvider;
  external ExtraLoginParamsJs get extraLoginOptions;
  external factory LoginParamsJs({
    String loginProvider,
    ExtraLoginParamsJs extraLoginOptions,
  });
}

@JS()
@anonymous
class ExtraLoginParamsJs {
  external String? get domain;
  external String? get verifierIdField;
  external String? get response_type;
  external String? get scope;
  external String? get id_token;
  external factory ExtraLoginParamsJs({
    String? domain,
    String? verifierIdField,
    String? response_type,
    String? scope,
    String? id_token,
  });
}

@JS()
@anonymous
class ProviderJs {
  external T? request<T>(RequestArgs request);
}

@JS()
@anonymous
class RequestArgs {
  external String get method;
  external factory RequestArgs({
    String method,
  });
}

@JS()
@anonymous
class UserInfo {
  external String? get email;
  external String? get name;
  external String? get profileImage;
  external String? get aggregateVerifier;
  external String? get verifier;
  external String? get verifierId;
  external String? get typeOfLogin;
  external String? get idToken;
  external String? get dappShare;
}

@JS()
@anonymous
class UserAuthInfo {
  external String get idToken;
}

@JS()
@anonymous
class LogoutOptions {
  external bool get cleanup;
  external factory LogoutOptions({
    bool cleanup,
  });
}

@JS()
@anonymous
class OpenloginAdapterJsParams {
  external AdapterSettingsJS get adapterSettings;
  external factory OpenloginAdapterJsParams(
      {AdapterSettingsJS adapterSettings,
      dynamic privateKeyProvider,
      LoginSettingsJS? loginSettings});
}

@JS('OpenloginAdapter.OpenloginAdapter')
class OpenloginAdapterJs {
  external factory OpenloginAdapterJs(OpenloginAdapterJsParams params);
}

@JS()
@anonymous
class AdapterSettingsJS {
  external String get network;
  external String get uxMode;
  external LoginConfigJs get loginConfig;
  external MFASettingsJs get mfaSettings;

  external factory AdapterSettingsJS(
      {String? uxMode,
      String network,
      LoginConfigJs loginConfig,
      MFASettingsJs? mfaSettings});
}

@JS()
@anonymous
class MFAOptionJs {
  external bool get enable;
  external int get priority;
  external bool get mandatory;

  external factory MFAOptionJs({
    bool enable,
    int priority,
    bool mandatory,
  });
}

@JS()
@anonymous
class MFASettingsJs {
  external MFAOptionJs? get deviceShareFactor;
  external MFAOptionJs? get backUpShareFactor;
  external MFAOptionJs? get socialBackupFactor;

  external factory MFASettingsJs({
    MFAOptionJs? deviceShareFactor,
    MFAOptionJs? backUpShareFactor,
    MFAOptionJs? socialBackupFactor,
    MFAOptionJs? passwordFactor,
  });
}

@JS()
@anonymous
class LoginSettingsJS {
  external bool get mfaLevel;

  external factory LoginSettingsJS({
    String? mfaLevel,
  });
}

@JS()
@anonymous
class LoginConfigJs {
  external String get network;
  external JWTConfigJs get jwt;

  external factory LoginConfigJs({
    JWTConfigJs jwt,
  });
}

@JS()
@anonymous
class JWTConfigJs {
  external String get name;
  external String get verifier;
  external String get typeOfLogin;
  external String get verifierSubIdentifier;
  external String get clientId;

  external factory JWTConfigJs({
    String? name,
    required String verifier,
    required String typeOfLogin,
    String verifierSubIdentifier,
    String? clientId,
  });
}
