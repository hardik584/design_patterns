import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_mode.dart';
import 'package:flutter/material.dart';

abstract class PaymentHandler {
  @protected
  PaymentHandler? next;
  void setNext(PaymentHandler next) {
    this.next = next;
  }

  String? handlePayment(double amount, {PaymentMode? paymentMode});
}
