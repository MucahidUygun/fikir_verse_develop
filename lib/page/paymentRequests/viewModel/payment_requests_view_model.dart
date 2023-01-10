import 'package:fikir_verse/core/model/cancel_payment_requests_model.dart';
import 'package:fikir_verse/core/model/payment_requests_control_model.dart';
import 'package:fikir_verse/core/model/payment_requests_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/payment_requests_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'payment_requests_view_model.g.dart';

class PaymentRequestsViewModel = _PaymentRequestsViewModelBase
    with _$PaymentRequestsViewModel;

abstract class _PaymentRequestsViewModelBase with Store {
  @observable
  PaymentRequestsModel? model;
  @observable
  CancelPaymentRequestsModel? cancelModel;

  @observable
  PaymentRequestsControl? checkControl;

  @observable
  PaymentRequestsControl? addPayment;

  @observable
  TextEditingController pointController = TextEditingController();

  @observable
  bool hasCancelRequests = true;
  @observable
  UpdateUserProfileModel? userModel;

  @action
  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    userModel = await UptadeUserProfileServices.getMyProfile(userId!);
  }

  @action
  addPaymentFunction() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');

    addPayment =
        await PaymentRequestsServices.addPayment(userId!, pointController.text);
  }

  @action
  getPaymentRequests() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');

    model = await PaymentRequestsServices.getPaymentRequests(userId!);
  }

  @action
  cancelPaymentRequestsFunction(String paymentActionId) async {
    cancelModel =
        await PaymentRequestsServices.cancelPaymentRequests(paymentActionId);
  }

  @action
  checkCancelPaymentRequests() {
    return cancelModel;
  }

  @action
  refreshPaymentRequests() async {
    await getPaymentRequests();
  }

  @action
  checkPaymentControl() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');

    checkControl =
        await PaymentRequestsServices.addPaymentRequestsControl(userId!);
  }

  isHasCancelRequests() {
    if (hasCancelRequests == false) {
      hasCancelRequests = true;
    } else {
      hasCancelRequests = false;
    }
  }
}
