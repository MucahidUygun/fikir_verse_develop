// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageViewModel on _HomePageViewModelBase, Store {
  final _$surveyModelAtom = Atom(name: '_HomePageViewModelBase.surveyModel');

  @override
  SurveyModel? get surveyModel {
    _$surveyModelAtom.reportRead();
    return super.surveyModel;
  }

  @override
  set surveyModel(SurveyModel? value) {
    _$surveyModelAtom.reportWrite(value, super.surveyModel, () {
      super.surveyModel = value;
    });
  }

  final _$attendedSurveyAtom =
      Atom(name: '_HomePageViewModelBase.attendedSurvey');

  @override
  List<AttendedSurvey>? get attendedSurvey {
    _$attendedSurveyAtom.reportRead();
    return super.attendedSurvey;
  }

  @override
  set attendedSurvey(List<AttendedSurvey>? value) {
    _$attendedSurveyAtom.reportWrite(value, super.attendedSurvey, () {
      super.attendedSurvey = value;
    });
  }

  final _$willJoinSurveyAtom =
      Atom(name: '_HomePageViewModelBase.willJoinSurvey');

  @override
  List<WillJoinSurvey>? get willJoinSurvey {
    _$willJoinSurveyAtom.reportRead();
    return super.willJoinSurvey;
  }

  @override
  set willJoinSurvey(List<WillJoinSurvey>? value) {
    _$willJoinSurveyAtom.reportWrite(value, super.willJoinSurvey, () {
      super.willJoinSurvey = value;
    });
  }

  final _$missedSurveyAtom = Atom(name: '_HomePageViewModelBase.missedSurvey');

  @override
  List<MissedSurvey>? get missedSurvey {
    _$missedSurveyAtom.reportRead();
    return super.missedSurvey;
  }

  @override
  set missedSurvey(List<MissedSurvey>? value) {
    _$missedSurveyAtom.reportWrite(value, super.missedSurvey, () {
      super.missedSurvey = value;
    });
  }

  final _$isNotClickAtom = Atom(name: '_HomePageViewModelBase.isNotClick');

  @override
  bool get isNotClick {
    _$isNotClickAtom.reportRead();
    return super.isNotClick;
  }

  @override
  set isNotClick(bool value) {
    _$isNotClickAtom.reportWrite(value, super.isNotClick, () {
      super.isNotClick = value;
    });
  }

  final _$modelAtom = Atom(name: '_HomePageViewModelBase.model');

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

  final _$refleshSurveyAsyncAction =
      AsyncAction('_HomePageViewModelBase.refleshSurvey');

  @override
  Future refleshSurvey() {
    return _$refleshSurveyAsyncAction.run(() => super.refleshSurvey());
  }

  final _$getUserModelAsyncAction =
      AsyncAction('_HomePageViewModelBase.getUserModel');

  @override
  Future getUserModel() {
    return _$getUserModelAsyncAction.run(() => super.getUserModel());
  }

  final _$_HomePageViewModelBaseActionController =
      ActionController(name: '_HomePageViewModelBase');

  @override
  dynamic changeIsNotClick() {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.changeIsNotClick');
    try {
      return super.changeIsNotClick();
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<AttendedSurvey> getAttendedSurvey() {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.getAttendedSurvey');
    try {
      return super.getAttendedSurvey();
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<MissedSurvey> getMissedSurveys() {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.getMissedSurveys');
    try {
      return super.getMissedSurveys();
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<WillJoinSurvey> getWillJoinSurveys() {
    final _$actionInfo = _$_HomePageViewModelBaseActionController.startAction(
        name: '_HomePageViewModelBase.getWillJoinSurveys');
    try {
      return super.getWillJoinSurveys();
    } finally {
      _$_HomePageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
surveyModel: ${surveyModel},
attendedSurvey: ${attendedSurvey},
willJoinSurvey: ${willJoinSurvey},
missedSurvey: ${missedSurvey},
isNotClick: ${isNotClick},
model: ${model}
    ''';
  }
}
