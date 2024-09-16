import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_mode.dart';
import 'package:flutter/material.dart';

class JuspayHandler extends PaymentHandler {
  @override
  String? handlePayment(double amount, {PaymentMode? paymentMode}) {
    if (paymentMode == PaymentMode.sip && amount > 0 && amount <= 5000) {
      debugPrint('Paid using Juspay: \$ $amount');
      return 'Paid using Juspay: \$ $amount';
    } else {
      return next?.handlePayment(amount, paymentMode: paymentMode);
    }
  }
}
