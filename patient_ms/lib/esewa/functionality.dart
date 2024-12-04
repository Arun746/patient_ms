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

  Future<Map<String, String>> pay(String appointmentId) async {
    Completer<Map<String, String>> completer = Completer<Map<String, String>>();
    String paymentStatus = 'unknown';
    String refid = '';
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: kEsewaClientId,
          secretId: kEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: appointmentId,
          productName: "Product One",
          productPrice: "2",
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          debugPrint('SUCCESS');
          paymentStatus = 'success';
          refid = result.refId.toString();
          completer.complete({'status': paymentStatus, 'refid': refid});
          verify(result);
        },
        onPaymentFailure: (result) {
          debugPrint('FAILURE');
          paymentStatus = 'failed';
          completer.complete({'status': paymentStatus, 'refid': refid});
        },
        onPaymentCancellation: (result) {
          debugPrint('CANCEL');
          paymentStatus = 'cancelled';
          completer.complete({'status': paymentStatus, 'refid': refid});
        },
      );
    } catch (e) {
      debugPrint('EXCEPTION');
      paymentStatus = '$e';
      completer.complete({'status': paymentStatus, 'refid': refid});
    }
    return completer.future;
  }

  void verify(EsewaPaymentSuccessResult result) async {
    // Handle verification logic here if needed
  }
}
