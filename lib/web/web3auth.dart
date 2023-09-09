import 'package:firebase_web3auth/interface/index.dart';
import 'package:firebase_web3auth/web/solana_provider.dart';
import 'package:firebase_web3auth/web/web3_auth_web.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:js/js_util.dart' as js_util;

class Web3AuthSDKWeb extends Web3AuthSDK {
  Web3AuthSDKWeb._();

  static Web3AuthSDKWeb instance = Web3AuthSDKWeb._();

  late Web3AuthNoModalWeb _web3auth;

  @override
  Future<void> init(ChainConfig config, Web3AuthOptions options) async {
    try {
      final chainConfigWeb = ChainConfigWeb(
          chainId: config.chainId,
          rpcTarget: config.rpcTarget,
          chainNamespace: config.chainNamespace,
          blockExplorer: config.blockExplorer,
          displayName: config.displayName,
          ticker: config.ticker,
          tickerName: config.tickerName);
      _web3auth = Web3AuthNoModalWeb(
        Web3AuthNoModalOptions(
          chainConfig: chainConfigWeb,
          clientId: options.clientId,
        ),
      );
      final provider = options.loginConfig![Provider.jwt.name];
      final privateKeyProvider = SolanaPrivateKeyProviderWeb(
        SolanaPrivateKeyProviderOptions(
          config: SolanaPrivKeyProviderConfig(chainConfig: chainConfigWeb),
        ),
      );
      _web3auth.configureAdapter(
        OpenloginAdapterJs(
          OpenloginAdapterJsParams(
            privateKeyProvider: privateKeyProvider,
            adapterSettings: AdapterSettingsJS(
              network: options.network.name,
              loginConfig: LoginConfigJs(
                jwt: JWTConfigJs(
                  verifier: provider!.verifier,
                  typeOfLogin: TypeOfLogin.jwt.name,
                  clientId: provider.clientId,
                ),
              ),
            ),
          ),
        ),
      );
      await js_util.promiseToFuture<void>(_web3auth.init());
    } catch (error, _) {
      throw Web3AuthException(
          code: Web3AuthExceptionCode.unknown, message: '$error');
    }
  }

  @override
  Future<LoginResponse> login(LoginParams options) async {
    try {
      final providerJs = await js_util.promiseToFuture<ProviderJs?>(
        _web3auth.connectTo(
          WalletAdapters.openlogin.name,
          LoginParamsJs(
            loginProvider: options.loginProvider.name,
            extraLoginOptions: ExtraLoginParamsJs(
              domain: options.extraLoginOptions?.domain,
              verifierIdField: options.extraLoginOptions?.verifierIdField,
              id_token: options.extraLoginOptions?.id_token,
            ),
          ),
        ),
      );
      if (providerJs == null) {
        return LoginResponse(error: "provide_not_found");
      }
      final solanaPrivateKey = await js_util.promiseToFuture(
        _web3auth.provider.request(
          RequestArgs(method: "solanaPrivateKey"),
        ),
      );
      final userInfo = await _web3auth.getUserInfo();

      return LoginResponse(
        ed25519PrivKey: solanaPrivateKey,
        userInfo: TorusUserInfo(
            email: userInfo.email,
            name: userInfo.name,
            profileImage: userInfo.profileImage,
            verifier: userInfo.verifier,
            verifierId: userInfo.verifierId,
            aggregateVerifier: userInfo.aggregateVerifier,
            idToken: userInfo.idToken,
            typeOfLogin: userInfo.typeOfLogin,
            dappShare: userInfo.dappShare),
      );
    } catch (error, _) {
      throw Web3AuthException(
          code: Web3AuthExceptionCode.unknown, message: '$error');
    }
  }
}
