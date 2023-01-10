// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_action_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PointActionViewModel on _PointActionViewModelBase, Store {
  final _$modelAtom = Atom(name: '_PointActionViewModelBase.model');

  @override
  PointActionModel? get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(PointActionModel? value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$userModelAtom = Atom(name: '_PointActionViewModelBase.userModel');

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
      AsyncAction('_PointActionViewModelBase.getUserModel');

  @override
  Future getUserModel() {
    return _$getUserModelAsyncAction.run(() => super.getUserModel());
  }

  final _$getServicesDataAsyncAction =
      AsyncAction('_PointActionViewModelBase.getServicesData');

  @override
  Future getServicesData() {
    return _$getServicesDataAsyncAction.run(() => super.getServicesData());
  }

  @override
  String toString() {
    return '''
model: ${model},
userModel: ${userModel}
    ''';
  }
}
