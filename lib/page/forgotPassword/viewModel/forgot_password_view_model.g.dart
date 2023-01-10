// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgotPasswordViewModel on _ForgotPasswordViewModelBase, Store {
  final _$isEmailValidAtom =
      Atom(name: '_ForgotPasswordViewModelBase.isEmailValid');

  @override
  bool get isEmailValid {
    _$isEmailValidAtom.reportRead();
    return super.isEmailValid;
  }

  @override
  set isEmailValid(bool value) {
    _$isEmailValidAtom.reportWrite(value, super.isEmailValid, () {
      super.isEmailValid = value;
    });
  }

  final _$isClickAtom = Atom(name: '_ForgotPasswordViewModelBase.isClick');

  @override
  bool get isClick {
    _$isClickAtom.reportRead();
    return super.isClick;
  }

  @override
  set isClick(bool value) {
    _$isClickAtom.reportWrite(value, super.isClick, () {
      super.isClick = value;
    });
  }

  final _$emailControllerAtom =
      Atom(name: '_ForgotPasswordViewModelBase.emailController');

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  final _$modelAtom = Atom(name: '_ForgotPasswordViewModelBase.model');

  @override
  ChangePasswordModel? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(ChangePasswordModel? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$forgotPasswordPostEmailAsyncAction =
      AsyncAction('_ForgotPasswordViewModelBase.forgotPasswordPostEmail');

  @override
  Future forgotPasswordPostEmail() {
    return _$forgotPasswordPostEmailAsyncAction
        .run(() => super.forgotPasswordPostEmail());
  }

  final _$_ForgotPasswordViewModelBaseActionController =
      ActionController(name: '_ForgotPasswordViewModelBase');

  @override
  dynamic changeIsClick() {
    final _$actionInfo = _$_ForgotPasswordViewModelBaseActionController
        .startAction(name: '_ForgotPasswordViewModelBase.changeIsClick');
    try {
      return super.changeIsClick();
    } finally {
      _$_ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? changeEmailValid(bool isValid) {
    final _$actionInfo = _$_ForgotPasswordViewModelBaseActionController
        .startAction(name: '_ForgotPasswordViewModelBase.changeEmailValid');
    try {
      return super.changeEmailValid(isValid);
    } finally {
      _$_ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearEmail() {
    final _$actionInfo = _$_ForgotPasswordViewModelBaseActionController
        .startAction(name: '_ForgotPasswordViewModelBase.clearEmail');
    try {
      return super.clearEmail();
    } finally {
      _$_ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEmailValid: ${isEmailValid},
isClick: ${isClick},
emailController: ${emailController},
model: ${model}
    ''';
  }
}
