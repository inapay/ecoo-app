import 'package:e_coupon/business/entities/transaction.dart';

class TransactionData extends Transaction {
  // in dart constructors do not get inherited, so everything has to be written again.
  TransactionData({String senderId, String recieverId, double amount})
      : super(senderId: senderId, recieverId: recieverId, amount: amount);
}

class RequestData extends Transaction {
  RequestData({String senderId, double amount})
      : super(senderId: senderId, amount: amount);
}
