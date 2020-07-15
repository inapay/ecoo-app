import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/use_cases/get_transactions.dart';
import 'package:e_coupon/business/use_cases/get_wallet.dart';
import 'package:e_coupon/ui/core/model/wallet_state.dart';
import 'package:e_coupon/ui/core/view_state/base_view_model.dart';
import 'package:e_coupon/ui/core/view_state/viewstate.dart';

import 'package:e_coupon/ui/core/widgets/transactions_list.dart';
import 'package:injectable/injectable.dart';

// add AppStateModel -> holds all wallets and the current selected... ?

@lazySingleton
class WalletViewModel extends BaseViewModel {
  Wallet _walletData;
  // WalletState walletState;
  List<TransactionListEntry> _walletTransactions;
  final GetWallet getWallet;
  final GetTransactions getTransactions;

  WalletViewModel({this.getWallet, this.getTransactions});

  Wallet get walletDetail => _walletData;
  List<TransactionListEntry> get walletDetailTransactions =>
      _walletTransactions;

  // void init(String walletId) async{

  // }

  void loadWalletDetail(String walletId) async {
    setViewState(Empty());

    if (walletId == null) {
      // TODO: handle in repository: if id == null get other data (from shared prefs) then if id != null
      walletId = 'DR345GH67';
    }
    // 2. load wallet from cache or init

    setViewState(Loading());

    var walletOrFailure = await getWallet(WalletParams(id: walletId));
    walletOrFailure.fold(
        (failure) => print('FAILURE'), (wallet) => _walletData = wallet);

    var transactionsOrFailure =
        await getTransactions(GetTransactionParams(id: walletId));
    transactionsOrFailure.fold((l) => print('FAILURE'), (transactions) {
      _walletTransactions = transactions
          .map((transaction) =>
              TransactionListEntry(transaction.text, transaction.amount))
          .toList();
    });

    setViewState(Loaded());
  }
}
