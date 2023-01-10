// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_requests_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentRequestsViewModel on _PaymentRequestsViewModelBase, Store {
  final _$modelAtom = Atom(name: '_PaymentRequestsViewModelBase.model');

  @override
  PaymentRequestsModel? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(PaymentRequestsModel? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$cancelModelAtom =
      Atom(name: '_PaymentRequestsViewModelBase.cancelModel');

  @override
  CancelPaymentRequestsModel? get cancelModel {
    _$cancelModelAtom.reportRead();
    return super.cancelModel;
  }

  @override
  set cancelModel(CancelPaymentRequestsModel? value) {
    _$cancelModelAtom.reportWrite(value, super.cancelModel, () {
      super.cancelModel = value;
    });
  }

  final _$checkControlAtom =
      Atom(name: '_PaymentRequestsViewModelBase.checkControl');

  @override
  PaymentRequestsControl? get checkControl {
    _$checkControlAtom.reportRead();
    return super.checkControl;
  }

  @override
  set checkControl(PaymentRequestsControl? value) {
    _$checkControlAtom.reportWrite(value, super.checkControl, () {
      super.checkControl = value;
    });
  }

  final _$addPaymentAtom =
      Atom(name: '_PaymentRequestsViewModelBase.addPayment');

  @override
  PaymentRequestsControl? get addPayment {
    _$addPaymentAtom.reportRead();
    return super.addPayment;
  }

  @override
  set addPayment(PaymentRequestsControl? value) {
    _$addPaymentAtom.reportWrite(value, super.addPayment, () {
      super.addPayment = value;
    });
  }

  final _$pointControllerAtom =
      Atom(name: '_PaymentRequestsViewModelBase.pointController');

  @override
  TextEditingController get pointController {
    _$pointControllerAtom.reportRead();
    return super.pointController;
  }

  @override
  set pointController(TextEditingController value) {
    _$pointControllerAtom.reportWrite(value, super.pointController, () {
      super.pointController = value;
    });
  }

  final _$hasCancelRequestsAtom =
      Atom(name: '_PaymentRequestsViewModelBase.hasCancelRequests');

  @override
  bool get hasCancelRequests {
    _$hasCancelRequestsAtom.reportRead();
    return super.hasCancelRequests;
  }

  @override
  set hasCancelRequests(bool value) {
    _$hasCancelRequestsAtom.reportWrite(value, super.hasCancelRequests, () {
      super.hasCancelRequests = value;
    });
  }

  final _$userModelAtom = Atom(name: '_PaymentRequestsViewModelBase.userModel');

  @override
  UpdateUserProfileModel? get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UpdateUserProfileModel? value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$getUserModelAsyncAction =
      AsyncAction('_PaymentRequestsViewModelBase.getUserModel');

  @override
  Future getUserModel() {
    return _$getUserModelAsyncAction.run(() => super.getUserModel());
  }

  final _$addPaymentFunctionAsyncAction =
      AsyncAction('_PaymentRequestsViewModelBase.addPaymentFunction');

  @override
  Future addPaymentFunction() {
    return _$addPaymentFunctionAsyncAction
        .run(() => super.addPaymentFunction());
  }

  final _$getPaymentRequestsAsyncAction =
      AsyncAction('_PaymentRequestsViewModelBase.getPaymentRequests');

  @override
  Future getPaymentRequests() {
    return _$getPaymentRequestsAsyncAction
        .run(() => super.getPaymentRequests());
  }

  final _$cancelPaymentRequestsFunctionAsyncAction = AsyncAction(
      '_PaymentRequestsViewModelBase.cancelPaymentRequestsFunction');

  @override
  Future cancelPaymentRequestsFunction(String paymentActionId) {
    return _$cancelPaymentRequestsFunctionAsyncAction
        .run(() => super.cancelPaymentRequestsFunction(paymentActionId));
  }

  final _$refreshPaymentRequestsAsyncAction =
      AsyncAction('_PaymentRequestsViewModelBase.refreshPaymentRequests');

  @override
  Future refreshPaymentRequests() {
    return _$refreshPaymentRequestsAsyncAction
        .run(() => super.refreshPaymentRequests());
  }

  final _$checkPaymentControlAsyncAction =
      AsyncAction('_PaymentRequestsViewModelBase.checkPaymentControl');

  @override
  Future checkPaymentControl() {
    return _$checkPaymentControlAsyncAction
        .run(() => super.checkPaymentControl());
  }

  final _$_PaymentRequestsViewModelBaseActionController =
      ActionController(name: '_PaymentRequestsViewModelBase');

  @override
  dynamic checkCancelPaymentRequests() {
    final _$actionInfo =
        _$_PaymentRequestsViewModelBaseActionController.startAction(
            name: '_PaymentRequestsViewModelBase.checkCancelPaymentRequests');
    try {
      return super.checkCancelPaymentRequests();
    } finally {
      _$_PaymentRequestsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
model: ${model},
cancelModel: ${cancelModel},
checkControl: ${checkControl},
addPayment: ${addPayment},
pointController: ${pointController},
hasCancelRequests: ${hasCancelRequests},
userModel: ${userModel}
    ''';
  }
}
