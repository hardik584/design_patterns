import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_mode.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler_impl/juspay_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler_impl/netbanking_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler_impl/paypal_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler/payment_handler.dart';
import 'package:design_patterns/chain_of_responsibility/payment_handler_impl/razorpay_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChainOfResponsibility extends StatefulWidget {
  const ChainOfResponsibility({super.key});

  @override
  State<ChainOfResponsibility> createState() => _ChainOfResponsibilityState();
}

class _ChainOfResponsibilityState extends State<ChainOfResponsibility> {
  /// Juspay => 1 to 5000
  /// Razorpay => 5001 to 100000
  /// NetBanking => 100001 & more

  /// Let's assume Now we have to do modification in it
  /// Juspay => 1 to 5000
  /// Razorpay => 5001 to 50000
  /// Paypal => 50001 to 100000
  /// NetBanking => 100001 & more

  PaymentHandler juspay = JuspayHandler();
  PaymentHandler razorpay = RazorpayHandler();
  PaymentHandler paypal = PaypalHandler();
  PaymentHandler netbanking = NetbankingHandler();

  TextEditingController amountController = TextEditingController();
  String? output;

  bool isSip = true;
  @override
  void initState() {
    super.initState();

    /// Juspay => 1 to 5000
    /// Razorpay => 5001 to 100000
    /// NetBanking => 100001 & more
    // juspay.setNext(razorpay);
    // razorpay.setNext(netbanking);

    /// Let's say Now we have to do little modification in it
    /// Juspay => 1 to 5000
    /// Razorpay => 5001 to 50000
    /// Paypal => 50001 to 100000
    /// NetBanking => 100001 & more
    juspay.setNext(razorpay);
    razorpay.setNext(paypal);
    paypal.setNext(netbanking);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment using Chain of Res.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('isSIP'),
            CupertinoSwitch(
              value: isSip,
              onChanged: (onChanged) {
                isSip = onChanged;
                setState(() {});
              },
            ),
            TextField(
              controller: amountController,
              maxLength: 10,
              decoration: InputDecoration(suffix: CloseButton(
                onPressed: () {
                  output = null;
                  amountController.clear();
                  setState(() {});
                },
              )),
            ),
            const SizedBox(height: 18),
            Wrap(
              children:
                  [500, 5000, 5001, 15000, 50000, 55000, 100000, 100001, 150000]
                      .map(
                        (value) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: ChoiceChip(
                            label: Text('$value'),
                            selected: false,
                            onSelected: (value1) {
                              amountController.text = value.toString();
                              setState(() {});
                            },
                          ),
                        ),
                      )
                      .toList(),
            ),
            CupertinoButton(
              child: const Text('Pay'),
              onPressed: () {
                if (amountController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Select amount and Pay'),
                  ));
                } else {
                  output = juspay.handlePayment(
                      double.parse(amountController.text.toString()),
                      paymentMode:
                          isSip ? PaymentMode.sip : PaymentMode.onetime);
                  setState(() {});
                }
              },
            ),
            Text(output ?? 'Select amount and Pay')
          ],
        ),
      ),
    );
  }
}
