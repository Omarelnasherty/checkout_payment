import 'package:checkout_payment/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:checkout_payment/core/utils/api_secret_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiKeys.publishableKey;

  await Stripe.instance.applySettings();

  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
