import 'package:e_coupon/business/core/abstract_use_case.dart';
import 'package:e_coupon/business/entities/wallet.dart';
import 'package:e_coupon/business/repo_definitions/abstract_wallet_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:dartz/dartz.dart';
import 'package:e_coupon/core/failure.dart';
import 'package:meta/meta.dart';

@lazySingleton
class GetWallet extends UseCase<Wallet, WalletParams> {
  final IWalletRepo repository;

  GetWallet({this.repository});

  Future<Either<Failure, Wallet>> call(WalletParams params) async {
    return await repository.getWalletData(params.id);
  }
}

class WalletParams extends Equatable {
  final String id;

  WalletParams({@required this.id});

  @override
  List<Object> get props => [id];
}