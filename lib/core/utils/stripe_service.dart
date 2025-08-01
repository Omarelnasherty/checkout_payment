import 'package:checkout_payment/Features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout_payment/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment/core/utils/api_secret_key.dart';
import 'package:checkout_payment/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();

  Future<PaymentIntentModel> createPaymentIntent(
    PaymentIntentInputModel paymentIntentInputModel,
  ) async {
    final body = {
      'amount': paymentIntentInputModel.amount.toString(),
      'currency': paymentIntentInputModel.currency,
      'customer': paymentIntentInputModel.customerId,
      'automatic_payment_methods[enabled]': 'true',
    };

    var response = await apiService.post(
      body: body,
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretKey,
      headers: {'Authorization': 'Bearer ${ApiKeys.secretKey}'},
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  }) async {
    var response = await apiService.post(
      body: {'customer': customerId},
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: ApiKeys.secretKey,
      headers: {
        'Authorization': 'Bearer ${ApiKeys.secretKey}',
        'Stripe-Version': '2023-08-16',
      },
    );

    var ephemeralKey = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKey;
  }

  Future<void> initPaymentSheet({
    required InitiPaymentSheetInputModel initiPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: initiPaymentSheetInputModel.clientSecret,
        customerEphemeralKeySecret:
            initiPaymentSheetInputModel.ephemeralKeySecret,
        customerId: initiPaymentSheetInputModel.customerId,
        merchantDisplayName: 'El-nasherty',
      ),
    );
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    final paymentIntentModel = await createPaymentIntent(
      paymentIntentInputModel,
    );

    final ephemeralKeyModel = await createEphemeralKey(
      customerId: paymentIntentInputModel.customerId,
    );

    final initPaymentSheetInputModel = InitiPaymentSheetInputModel(
      clientSecret: paymentIntentModel.clientSecret!,
      customerId: paymentIntentInputModel.customerId,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
    );

    await initPaymentSheet(
      initiPaymentSheetInputModel: initPaymentSheetInputModel,
    );

    await displayPaymentSheet();
  }
}
