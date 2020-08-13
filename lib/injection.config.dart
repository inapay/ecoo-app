// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/e_coupon_library/lib_wallet_source.dart';
import 'data/local/local_wallet_source.dart';
import 'data/mock_network_info.dart';
import 'data/network_info.dart';
import 'data/repos/abstract_wallet_repo.dart';
import 'data/repos/wallet_repo.dart';
import 'main.dart';
import 'modules/third_party_library_module.dart';
import 'ui/core/router/router.dart';
import 'ui/core/services/app_service.dart';
import 'ui/core/services/login_service.dart';
import 'ui/core/services/mock_login_service.dart';
import 'ui/core/services/notification_service.dart';
import 'ui/core/services/profile_service.dart';
import 'ui/core/services/settings_service.dart';
import 'ui/core/services/transfer_service.dart';
import 'ui/core/services/wallet_service.dart';
import 'ui/screens/menu/menu_screen.dart';
import 'ui/screens/menu/menu_screen_view_model.dart';
import 'ui/screens/payment/error_screen.dart';
import 'ui/screens/payment/payment_screen.dart';
import 'ui/screens/payment/payment_view_model.dart';
import 'ui/screens/payment/qr_scanner_view_model.dart';
import 'ui/screens/payment/qrbill_screen.dart';
import 'ui/screens/payment/qrbill_view_model.dart';
import 'ui/screens/payment/request_screen.dart';
import 'ui/screens/payment/request_view_model.dart';
import 'ui/screens/payment/success_view_model.dart';
import 'ui/screens/redeem/redeem_screen.dart';
import 'ui/screens/redeem/redeem_view_model.dart';
import 'ui/screens/register/register_screen.dart';
import 'ui/screens/register/register_screen_view_model.dart';
import 'ui/screens/register/register_verifiy_screen.dart';
import 'ui/screens/register/register_verify_screen_view_model.dart';
import 'ui/screens/register/register_wallet_type_screen.dart';
import 'ui/screens/register/register_wallet_type_screen_view_model.dart';
import 'ui/screens/start/onboarding_screen.dart';
import 'ui/screens/start/onboarding_screen_view_model.dart';
import 'ui/screens/start/splash_screen.dart';
import 'ui/screens/start/splash_screen_view_model.dart';
import 'ui/screens/verification/pin_verification_screen.dart';
import 'ui/screens/verification/pin_verification_view_model.dart';
import 'ui/screens/verification/verification_screen.dart';
import 'ui/screens/verification/verification_view_model.dart';
import 'ui/screens/wallet/qr_overlay.dart';
import 'ui/screens/wallet/wallet_screen.dart';
import 'ui/screens/wallet/wallet_view_model.dart';
import 'ui/screens/wallets_overview/wallets_view_model.dart';

/// Environment names
const _prod = 'prod';
const _dev = 'dev';
const _mock = 'mock';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<void> $initGetIt(GetIt g, {String environment}) async {
  final gh = GetItHelper(g, environment);
  final thirdPartyLibraryModule = _$ThirdPartyLibraryModule();
  gh.factory<ErrorScreen>(() => ErrorScreen());
  gh.factory<FlutterSecureStorage>(() => thirdPartyLibraryModule.securePrefs);
  gh.lazySingleton<ILocalWalletSource>(() => LocalWalletSource());
  gh.lazySingleton<INetworkInfo>(() => NetworkInfo(), registerFor: {_prod});
  gh.lazySingleton<INetworkInfo>(() => MockNetworkInfo(),
      registerFor: {_dev, _mock});
  gh.lazySingleton<ITransferService>(() => TransferService());
  gh.lazySingleton<IWalletSource>(() => WalletSource());
  gh.lazySingleton<MockLoginService>(
      () => MockLoginService(g<IWalletSource>()));
  final packageInfo = await thirdPartyLibraryModule.packageInfo;
  gh.factory<PackageInfo>(() => packageInfo);
  gh.factory<PaymentScreen>(() => PaymentScreen());
  gh.factory<RegisterVerifyScreenViewModel>(
      () => RegisterVerifyScreenViewModel(g<IRouter>()));
  gh.factory<RequestQRBillScreen>(() => RequestQRBillScreen());
  gh.factory<RequestScreen>(() => RequestScreen());
  final sharedPreferences = await thirdPartyLibraryModule.prefs;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.factory<SuccessViewModel>(() => SuccessViewModel());
  gh.factory<WalletScreen>(() => WalletScreen());
  gh.factory<ECouponApp>(() => ECouponApp(g<IRouter>()));
  gh.factory<IAppService>(() => AppService(g<PackageInfo>()));
  gh.factory<ISettingsService>(
      () => SettingsService(g<SharedPreferences>(), g<FlutterSecureStorage>()));
  gh.lazySingleton<IWalletRepo>(
      () => WalletRepo(
            localDataSource: g<ILocalWalletSource>(),
            networkInfo: g<INetworkInfo>(),
            walletSource: g<IWalletSource>(),
          ),
      registerFor: {_prod, _dev});
  gh.lazySingleton<IWalletService>(
      () => WalletService(g<IWalletRepo>(), g<ISettingsService>()));
  gh.factory<MenuScreenViewModel>(
      () => MenuScreenViewModel(g<IAppService>(), g<IRouter>()));
  gh.factory<OnboardingScreenViewModel>(
      () => OnboardingScreenViewModel(g<IRouter>(), g<ISettingsService>()));
  gh.factory<PaymentViewModel>(() => PaymentViewModel(
        g<IRouter>(),
        g<IWalletService>(),
        g<ITransferService>(),
        g<IWalletRepo>(),
      ));
  gh.factory<QRBillViewModel>(() => QRBillViewModel(
        g<ITransferService>(),
        g<IRouter>(),
        g<IWalletService>(),
      ));
  gh.factory<QRScannerViewModel>(() => QRScannerViewModel(
        g<IRouter>(),
        g<ITransferService>(),
        g<IWalletService>(),
        g<IWalletRepo>(),
      ));
  gh.factory<RedeemViewModel>(
      () => RedeemViewModel(g<IWalletService>(), g<IRouter>()));
  gh.factory<RegisterVerifyScreen>(
      () => RegisterVerifyScreen(g<RegisterVerifyScreenViewModel>()));
  gh.factory<RegisterWalletTypeScreenViewModel>(
      () => RegisterWalletTypeScreenViewModel(
            g<IRouter>(),
            g<IWalletService>(),
            g<IWalletRepo>(),
          ));
  gh.factory<RequestViewModel>(() => RequestViewModel(
        g<ITransferService>(),
        g<IWalletService>(),
        g<IRouter>(),
      ));
  gh.factory<WalletQROverlay>(() => WalletQROverlay(g<IWalletService>()));
  gh.lazySingleton<WalletViewModel>(() => WalletViewModel(
        g<IRouter>(),
        g<IWalletService>(),
        g<MockLoginService>(),
        g<INetworkInfo>(),
      ));
  gh.factory<WalletsViewModel>(() => WalletsViewModel(
        g<IWalletService>(),
        g<IRouter>(),
        g<INetworkInfo>(),
      ));
  gh.factory<INotificationService>(
      () => NotificationService(g<IWalletSource>(), g<ISettingsService>()));
  gh.factory<MenuScreen>(() => MenuScreen(g<MenuScreenViewModel>()));
  gh.factory<OnboardingScreen>(
      () => OnboardingScreen(g<OnboardingScreenViewModel>()));
  gh.factory<PinVerificationViewModel>(() => PinVerificationViewModel(
        g<IWalletService>(),
        g<IRouter>(),
        g<IProfileService>(),
      ));
  gh.factory<RedeemScreen>(() => RedeemScreen(g<RedeemViewModel>()));
  gh.factory<RegisterWalletTypeScreen>(
      () => RegisterWalletTypeScreen(g<RegisterWalletTypeScreenViewModel>()));
  gh.factory<VerificationViewModel>(() => VerificationViewModel(
        g<IWalletService>(),
        g<IProfileService>(),
        g<IRouter>(),
      ));
  gh.factory<ILoginService>(() => LoginService(
        g<IWalletSource>(),
        g<ISettingsService>(),
        g<IProfileService>(),
        g<INotificationService>(),
      ));
  gh.factory<PinVerificationScreen>(
      () => PinVerificationScreen(g<PinVerificationViewModel>()));
  gh.factory<RegisterScreenViewModel>(
      () => RegisterScreenViewModel(g<IRouter>(), g<ILoginService>()));
  gh.factory<SplashScreenViewModel>(() => SplashScreenViewModel(
        g<IRouter>(),
        g<ILoginService>(),
        g<INotificationService>(),
      ));
  gh.factory<VerificationScreen>(
      () => VerificationScreen(g<VerificationViewModel>()));
  gh.factory<RegisterScreen>(
      () => RegisterScreen(g<RegisterScreenViewModel>()));
  gh.factory<SplashScreen>(() => SplashScreen(g<SplashScreenViewModel>()));

  // Eager singletons must be registered in the right order
  gh.singleton<IRouter>(Router());
  gh.singleton<IProfileService>(ProfileService(
    g<IWalletRepo>(),
    g<IWalletService>(),
    g<ISettingsService>(),
  ));
}

class _$ThirdPartyLibraryModule extends ThirdPartyLibraryModule {}
