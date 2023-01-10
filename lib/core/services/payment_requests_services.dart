import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/cancel_payment_requests_model.dart';
import 'package:fikir_verse/core/model/payment_requests_control_model.dart';
import 'package:fikir_verse/core/model/payment_requests_model.dart';

class PaymentRequestsServices {
  static Future<PaymentRequestsModel> getPaymentRequests(String userId) async {
    try {
      var respose = await NetworkClient.instance!.dio.get(
          '$siteBaseUrl/api/my-account/$userId/$token/getMyPaymentRequests');
      return PaymentRequestsModel.fromJson(respose.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<CancelPaymentRequestsModel> cancelPaymentRequests(
      String paymentActionId) async {
    try {
      var formData = FormData.fromMap(
          {'payment_action_id': paymentActionId, 'token': token});

      var response = await NetworkClient.instance!.dio.post(
          '$siteBaseUrl/api/my-account/cancelPaymentRequest',
          data: formData);
      return CancelPaymentRequestsModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<PaymentRequestsControl> addPaymentRequestsControl(
      String userId) async {
    try {
      var formData = FormData.fromMap({'user_id': userId, 'token': token});

      var response = await NetworkClient.instance!.dio.post(
          '$siteBaseUrl/api/my-account/$userId/paymentRequestControl',
          data: formData);
      return PaymentRequestsControl.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<PaymentRequestsControl> addPayment(
      String userId, String paymentActionPoint) async {
    try {
      var formData = FormData.fromMap({
        'payment_action_point': paymentActionPoint,
        'user_id': userId,
        'token': token
      });

      var response = await NetworkClient.instance!.dio.post(
          '$siteBaseUrl/api/my-account/createPaymentRequest',
          data: formData);
      return PaymentRequestsControl.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
