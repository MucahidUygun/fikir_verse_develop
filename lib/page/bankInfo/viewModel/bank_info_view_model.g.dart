// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_info_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BankInfoViewModel on _BankInfoViewModelBase, Store {
  final _$bankNameAtom = Atom(name: '_BankInfoViewModelBase.bankName');

  @override
  TextEditingController get bankName {
    _$bankNameAtom.reportRead();
    return super.bankName;
  }

  @override
  set bankName(TextEditingController value) {
    _$bankNameAtom.reportWrite(value, super.bankName, () {
      super.bankName = value;
    });
  }

  final _$ibanTextAtom = Atom(name: '_BankInfoViewModelBase.ibanText');

  @override
  TextEditingController get ibanText {
    _$ibanTextAtom.reportRead();
    return super.ibanText;
  }

  @override
  set ibanText(TextEditingController value) {
    _$ibanTextAtom.reportWrite(value, super.ibanText, () {
      super.ibanText = value;
    });
  }

  final _$modelAtom = Atom(name: '_BankInfoViewModelBase.model');

  @override
  GetBankInfoModel get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(GetBankInfoModel value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$accountNameSurnameAtom =
      Atom(name: '_BankInfoViewModelBase.accountNameSurname');

  @override
  TextEditingController get accountNameSurname {
    _$accountNameSurnameAtom.reportRead();
    return super.accountNameSurname;
  }

  @override
  set accountNameSurname(TextEditingController value) {
    _$accountNameSurnameAtom.reportWrite(value, super.accountNameSurname, () {
      super.accountNameSurname = value;
    });
  }

  final _$branchCodeAtom = Atom(name: '_BankInfoViewModelBase.branchCode');

  @override
  TextEditingController get branchCode {
    _$branchCodeAtom.reportRead();
    return super.branchCode;
  }

  @override
  set branchCode(TextEditingController value) {
    _$branchCodeAtom.reportWrite(value, super.branchCode, () {
      super.branchCode = value;
    });
  }

  final _$accountNumberAtom =
      Atom(name: '_BankInfoViewModelBase.accountNumber');

  @override
  TextEditingController get accountNumber {
    _$accountNumberAtom.reportRead();
    return super.accountNumber;
  }

  @override
  set accountNumber(TextEditingController value) {
    _$accountNumberAtom.reportWrite(value, super.accountNumber, () {
      super.accountNumber = value;
    });
  }

  final _$isShowDeleteButtonAtom =
      Atom(name: '_BankInfoViewModelBase.isShowDeleteButton');

  @override
  bool get isShowDeleteButton {
    _$isShowDeleteButtonAtom.reportRead();
    return super.isShowDeleteButton;
  }

  @override
  set isShowDeleteButton(bool value) {
    _$isShowDeleteButtonAtom.reportWrite(value, super.isShowDeleteButton, () {
      super.isShowDeleteButton = value;
    });
  }

  final _$numberTCAtom = Atom(name: '_BankInfoViewModelBase.numberTC');

  @override
  TextEditingController get numberTC {
    _$numberTCAtom.reportRead();
    return super.numberTC;
  }

  @override
  set numberTC(TextEditingController value) {
    _$numberTCAtom.reportWrite(value, super.numberTC, () {
      super.numberTC = value;
    });
  }

  final _$userModelAtom = Atom(name: '_BankInfoViewModelBase.userModel');

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
      AsyncAction('_BankInfoViewModelBase.getUserModel');

  @override
  Future getUserModel() {
    return _$getUserModelAsyncAction.run(() => super.getUserModel());
  }

  final _$getBankInfoFunctionAsyncAction =
      AsyncAction('_BankInfoViewModelBase.getBankInfoFunction');

  @override
  Future getBankInfoFunction() {
    return _$getBankInfoFunctionAsyncAction
        .run(() => super.getBankInfoFunction());
  }

  final _$deleteBankInfoFunctionAsyncAction =
      AsyncAction('_BankInfoViewModelBase.deleteBankInfoFunction');

  @override
  Future deleteBankInfoFunction() {
    return _$deleteBankInfoFunctionAsyncAction
        .run(() => super.deleteBankInfoFunction());
  }

  final _$_BankInfoViewModelBaseActionController =
      ActionController(name: '_BankInfoViewModelBase');

  @override
  dynamic clearTextController() {
    final _$actionInfo = _$_BankInfoViewModelBaseActionController.startAction(
        name: '_BankInfoViewModelBase.clearTextController');
    try {
      return super.clearTextController();
    } finally {
      _$_BankInfoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic checkDeleteButton({bool? postStatus}) {
    final _$actionInfo = _$_BankInfoViewModelBaseActionController.startAction(
        name: '_BankInfoViewModelBase.checkDeleteButton');
    try {
      return super.checkDeleteButton(postStatus: postStatus);
    } finally {
      _$_BankInfoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bankName: ${bankName},
ibanText: ${ibanText},
model: ${model},
accountNameSurname: ${accountNameSurname},
branchCode: ${branchCode},
accountNumber: ${accountNumber},
isShowDeleteButton: ${isShowDeleteButton},
numberTC: ${numberTC},
userModel: ${userModel}
    ''';
  }
}
