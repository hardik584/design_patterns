import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_mode.dart';
import 'package:flutter/material.dart';

class NetbankingHandler extends PaymentHandler {
  @override
  String? handlePayment(double amount, {PaymentMode? paymentMode}) {
    if (amount > 100000) {
      debugPrint('Paid using Net Banking: \$ $amount');
      return 'Paid using Net Banking: \$ $amount';
    } else {
      return next?.handlePayment(amount, paymentMode: paymentMode);
    }
  }
}
