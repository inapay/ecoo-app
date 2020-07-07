import 'package:e_coupon/ui/screens/transaction_screens/payment/payment_overview_screen.dart';
import 'package:e_coupon/ui/screens/transaction_screens/payment/payment_screen.dart';
import 'package:e_coupon/ui/screens/verification/verification_screen.dart';
import 'package:e_coupon/ui/screens/wallet/wallet_screen.dart';
import 'package:e_coupon/ui/screens/wallets_overview/wallets_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// unfortunately routesetting does not allow enums
const HomeRoute = '/';
const WalletDetailRoute = 'walletDetail';
const WalletsOverviewRoute = 'walletsOverview';
const VerificationRoute = 'verification';
const PaymentRoute = 'payment';
const PaymentOverviewRoute = 'paymentOverview';
// still TODO:
const SuccessRoute = 'success';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute:
      case WalletDetailRoute:
        var walletId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => WalletScreen(walletId: walletId));
      case WalletsOverviewRoute:
        // var post = settings.arguments as Post;
        // return MaterialPageRoute(builder: (_) => WalletScreen(post: post));
        return MaterialPageRoute(builder: (_) => WalletsOverviewScreen());
      case VerificationRoute:
        return MaterialPageRoute(builder: (_) => VerificationScreen());
      case PaymentRoute:
        var senderID = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(senderID: senderID));
      case PaymentOverviewRoute:
        print('router arguments');
        print(settings.arguments);
        final PaymentOverviewArguments args =
            settings.arguments as PaymentOverviewArguments;
        return MaterialPageRoute(
            builder: (_) => PaymentOverviewScreen(
                  arguments: args,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}