import 'package:checkout_payment/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment/core/utils/api_secret_key.dart';
import 'package:checkout_payment/core/utils/api_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretKey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  Future initPaymentSheet({required paymentIntentClientSecret}) async {
    Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'Omar Elnasherty',
      ),
    );
  }

  Future displayPaymentSheet() async {
    Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntentModel.clientSecret,
    );
    await displayPaymentSheet();
  }
}
