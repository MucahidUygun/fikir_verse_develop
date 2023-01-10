// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangePasswordViewModel on _ChangePasswordViewModelBase, Store {
  final _$currentPasswordAtom =
      Atom(name: '_ChangePasswordViewModelBase.currentPassword');

  @override
  TextEditingController get currentPassword {
    _$currentPasswordAtom.reportRead();
    return super.currentPassword;
  }

  @override
  set currentPassword(TextEditingController value) {
    _$currentPasswordAtom.reportWrite(value, super.currentPassword, () {
      super.currentPassword = value;
    });
  }

  final _$userPasswordAtom =
      Atom(name: '_ChangePasswordViewModelBase.userPassword');

  @override
  TextEditingController get userPassword {
    _$userPasswordAtom.reportRead();
    return super.userPassword;
  }

  @override
  set userPassword(TextEditingController value) {
    _$userPasswordAtom.reportWrite(value, super.userPassword, () {
      super.userPassword = value;
    });
  }

  final _$userPasswordAgainAtom =
      Atom(name: '_ChangePasswordViewModelBase.userPasswordAgain');

  @override
  TextEditingController get userPasswordAgain {
    _$userPasswordAgainAtom.reportRead();
    return super.userPasswordAgain;
  }

  @override
  set userPasswordAgain(TextEditingController value) {
    _$userPasswordAgainAtom.reportWrite(value, super.userPasswordAgain, () {
      super.userPasswordAgain = value;
    });
  }

  final _$currentPasswordObscureTextAtom =
      Atom(name: '_ChangePasswordViewModelBase.currentPasswordObscureText');

  @override
  bool get currentPasswordObscureText {
    _$currentPasswordObscureTextAtom.reportRead();
    return super.currentPasswordObscureText;
  }

  @override
  set currentPasswordObscureText(bool value) {
    _$currentPasswordObscureTextAtom
        .reportWrite(value, super.currentPasswordObscureText, () {
      super.currentPasswordObscureText = value;
    });
  }

  final _$userPasswordObscureTextAtom =
      Atom(name: '_ChangePasswordViewModelBase.userPasswordObscureText');

  @override
  bool get userPasswordObscureText {
    _$userPasswordObscureTextAtom.reportRead();
    return super.userPasswordObscureText;
  }

  @override
  set userPasswordObscureText(bool value) {
    _$userPasswordObscureTextAtom
        .reportWrite(value, super.userPasswordObscureText, () {
      super.userPasswordObscureText = value;
    });
  }

  final _$userPasswordAgainObscureTextAtom =
      Atom(name: '_ChangePasswordViewModelBase.userPasswordAgainObscureText');

  @override
  bool get userPasswordAgainObscureText {
    _$userPasswordAgainObscureTextAtom.reportRead();
    return super.userPasswordAgainObscureText;
  }

  @override
  set userPasswordAgainObscureText(bool value) {
    _$userPasswordAgainObscureTextAtom
        .reportWrite(value, super.userPasswordAgainObscureText, () {
      super.userPasswordAgainObscureText = value;
    });
  }

  final _$modelAtom = Atom(name: '_ChangePasswordViewModelBase.model');

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

  final _$isClickAtom = Atom(name: '_ChangePasswordViewModelBase.isClick');

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

  final _$getUserModelAsyncAction =
      AsyncAction('_ChangePasswordViewModelBase.getUserModel');

  @override
  Future getUserModel() {
    return _$getUserModelAsyncAction.run(() => super.getUserModel());
  }

  final _$pushPasswordAsyncAction =
      AsyncAction('_ChangePasswordViewModelBase.pushPassword');

  @override
  Future<ChangePasswordModel> pushPassword() {
    return _$pushPasswordAsyncAction.run(() => super.pushPassword());
  }

  final _$_ChangePasswordViewModelBaseActionController =
      ActionController(name: '_ChangePasswordViewModelBase');

  @override
  dynamic changeIsClick() {
    final _$actionInfo = _$_ChangePasswordViewModelBaseActionController
        .startAction(name: '_ChangePasswordViewModelBase.changeIsClick');
    try {
      return super.changeIsClick();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic currentPasswordChangeObscure() {
    final _$actionInfo =
        _$_ChangePasswordViewModelBaseActionController.startAction(
            name: '_ChangePasswordViewModelBase.currentPasswordChangeObscure');
    try {
      return super.currentPasswordChangeObscure();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic userPasswordChangeObscure() {
    final _$actionInfo =
        _$_ChangePasswordViewModelBaseActionController.startAction(
            name: '_ChangePasswordViewModelBase.userPasswordChangeObscure');
    try {
      return super.userPasswordChangeObscure();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic userPasswordAgainChangeObscure() {
    final _$actionInfo =
        _$_ChangePasswordViewModelBaseActionController.startAction(
            name:
                '_ChangePasswordViewModelBase.userPasswordAgainChangeObscure');
    try {
      return super.userPasswordAgainChangeObscure();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool checkNewPassword() {
    final _$actionInfo = _$_ChangePasswordViewModelBaseActionController
        .startAction(name: '_ChangePasswordViewModelBase.checkNewPassword');
    try {
      return super.checkNewPassword();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool chechInputBox() {
    final _$actionInfo = _$_ChangePasswordViewModelBaseActionController
        .startAction(name: '_ChangePasswordViewModelBase.chechInputBox');
    try {
      return super.chechInputBox();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearTextController() {
    final _$actionInfo = _$_ChangePasswordViewModelBaseActionController
        .startAction(name: '_ChangePasswordViewModelBase.clearTextController');
    try {
      return super.clearTextController();
    } finally {
      _$_ChangePasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPassword: ${currentPassword},
userPassword: ${userPassword},
userPasswordAgain: ${userPasswordAgain},
currentPasswordObscureText: ${currentPasswordObscureText},
userPasswordObscureText: ${userPasswordObscureText},
userPasswordAgainObscureText: ${userPasswordAgainObscureText},
model: ${model},
isClick: ${isClick}
    ''';
  }
}
