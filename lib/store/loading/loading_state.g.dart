// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoadingState on _LoadingState, Store {
  final _$loadingAtom = Atom(name: '_LoadingState.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$_LoadingStateActionController =
      ActionController(name: '_LoadingState');

  @override
  void startLoading() {
    final _$actionInfo = _$_LoadingStateActionController.startAction(
        name: '_LoadingState.startLoading');
    try {
      return super.startLoading();
    } finally {
      _$_LoadingStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopLoading() {
    final _$actionInfo = _$_LoadingStateActionController.startAction(
        name: '_LoadingState.stopLoading');
    try {
      return super.stopLoading();
    } finally {
      _$_LoadingStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
