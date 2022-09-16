// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EmployeeStore on _EmployeeStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_EmployeeStore.isLoading'))
          .value;

  late final _$successAtom =
      Atom(name: '_EmployeeStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_EmployeeStore.loading', context: context);

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

  late final _$userNameAtom =
      Atom(name: '_EmployeeStore.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$loginFutureAtom =
      Atom(name: '_EmployeeStore.loginFuture', context: context);

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  late final _$searchTermAtom =
      Atom(name: '_EmployeeStore.searchTerm', context: context);

  @override
  String get searchTerm {
    _$searchTermAtom.reportRead();
    return super.searchTerm;
  }

  @override
  set searchTerm(String value) {
    _$searchTermAtom.reportWrite(value, super.searchTerm, () {
      super.searchTerm = value;
    });
  }

  late final _$employeeListAtom =
      Atom(name: '_EmployeeStore.employeeList', context: context);

  @override
  ObservableList<Employee> get employeeList {
    _$employeeListAtom.reportRead();
    return super.employeeList;
  }

  @override
  set employeeList(ObservableList<Employee> value) {
    _$employeeListAtom.reportWrite(value, super.employeeList, () {
      super.employeeList = value;
    });
  }

  late final _$getEmployeeDataAsyncAction =
      AsyncAction('_EmployeeStore.getEmployeeData', context: context);

  @override
  Future<bool> getEmployeeData() {
    return _$getEmployeeDataAsyncAction.run(() => super.getEmployeeData());
  }

  late final _$searchByNameAsyncAction =
      AsyncAction('_EmployeeStore.searchByName', context: context);

  @override
  Future<dynamic> searchByName(String filter) {
    return _$searchByNameAsyncAction.run(() => super.searchByName(filter));
  }

  late final _$_EmployeeStoreActionController =
      ActionController(name: '_EmployeeStore', context: context);

  @override
  dynamic setIsLoggedIn(bool value) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.setIsLoggedIn');
    try {
      return super.setIsLoggedIn(value);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchTerm(String value) {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.setSearchTerm');
    try {
      return super.setSearchTerm(value);
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_EmployeeStoreActionController.startAction(
        name: '_EmployeeStore.dispose');
    try {
      return super.dispose();
    } finally {
      _$_EmployeeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
success: ${success},
loading: ${loading},
userName: ${userName},
loginFuture: ${loginFuture},
searchTerm: ${searchTerm},
employeeList: ${employeeList},
isLoading: ${isLoading}
    ''';
  }
}
