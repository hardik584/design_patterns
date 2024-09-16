import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_mode.dart';
import 'package:flutter/material.dart';

class PaypalHandler extends PaymentHandler {
  @override
  String? handlePayment(double amount, {PaymentMode? paymentMode}) {
    if (paymentMode == PaymentMode.sip && amount > 50000 && amount <= 100000) {
      debugPrint('Paid using Paypal: \$ $amount');
      return 'Paid using Paypal: \$ $amount';
    } else {
      return next?.handlePayment(amount, paymentMode: paymentMode);
    }
  }
}
