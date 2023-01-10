// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  final _$emailControllerAtom =
      Atom(name: '_LoginViewModelBase.emailController');

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

  final _$passwordControllerAtom =
      Atom(name: '_LoginViewModelBase.passwordController');

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  final _$obscureTextAtom = Atom(name: '_LoginViewModelBase.obscureText');

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  final _$isEmailValidAtom = Atom(name: '_LoginViewModelBase.isEmailValid');

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

  final _$modelAtom = Atom(name: '_LoginViewModelBase.model');

  @override
  UpdateUserProfileModel? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(UpdateUserProfileModel? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$loginUserAsyncAction = AsyncAction('_LoginViewModelBase.loginUser');

  @override
  Future loginUser() {
    return _$loginUserAsyncAction.run(() => super.loginUser());
  }

  final _$getUserModelAsyncAction =
      AsyncAction('_LoginViewModelBase.getUserModel');

  @override
  Future getUserModel(String userId) {
    return _$getUserModelAsyncAction.run(() => super.getUserModel(userId));
  }

  final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase');

  @override
  dynamic changeObscure() {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.changeObscure');
    try {
      return super.changeObscure();
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? changeEmailValid(bool isValid) {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.changeEmailValid');
    try {
      return super.changeEmailValid(isValid);
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailController: ${emailController},
passwordController: ${passwordController},
obscureText: ${obscureText},
isEmailValid: ${isEmailValid},
model: ${model}
    ''';
  }
}
