// ignore_for_file: depend_on_referenced_packages

import 'package:patient_ms/esewa/constants.dart';
import 'package:flutter/material.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';

import 'dart:async';

class Esewa {
  Esewa();

  Future<String> pay() async {
    Completer<String> completer = Completer<String>(); // Create a Completer
    String paymentStatus = 'unknown'; // Default status

    try {
      // Call initPayment without await
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: kEsewaClientId,
          secretId: kEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: "1d71jd81",
          productName: "Product One",
          productPrice: "2",
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          debugPrint('SUCCESS');
          paymentStatus = 'success';
          completer.complete(paymentStatus);
          verify(result);
        },
        onPaymentFailure: (result) {
          debugPrint('FAILURE');
          paymentStatus = 'failed';
          completer.complete(paymentStatus);
        },
        onPaymentCancellation: (result) {
          debugPrint('CANCEL');
          paymentStatus = 'cancelled';
          completer.complete(paymentStatus);
        },
      );
    } catch (e) {
      debugPrint('EXCEPTION');
      paymentStatus = '$e';
      completer.complete(paymentStatus);
    }

    return completer.future;
  }

  void verify(EsewaPaymentSuccessResult result) async {
    // Handle verification logic here if needed
  }
}
