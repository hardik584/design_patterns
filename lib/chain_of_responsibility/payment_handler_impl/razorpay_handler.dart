import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_mode.dart';
import 'package:flutter/material.dart';

class RazorpayHandler extends PaymentHandler {
  @override
  String? handlePayment(double amount, {PaymentMode? paymentMode}) {
    if (paymentMode == PaymentMode.onetime && amount > 0 && amount <= 100000) {
      debugPrint('Paid using Razorpay: \$ $amount');
      return 'Paid using Razorpay: \$ $amount';
    } else if (paymentMode == PaymentMode.sip &&
        amount > 5000 &&
        amount <= 50000) {
      debugPrint('Paid using Razorpay: \$ $amount');
      return 'Paid using Razorpay: \$ $amount';
    } else {
      return next?.handlePayment(amount, paymentMode: paymentMode);
    }
  }
}
