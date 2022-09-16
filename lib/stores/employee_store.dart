import 'package:employee/model/employee_list.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../model/employee_model.dart';

part 'employee_store.g.dart';

class EmployeeStore = _EmployeeStore with _$EmployeeStore;

abstract class _EmployeeStore with Store {
  // repository instance
  final Repository _repository;

  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _EmployeeStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
      ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  String userName = '';

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------

  @action
  setIsLoggedIn(bool value) {
    isLoggedIn = false;
  }

  @observable
  String searchTerm = '';

  @action
  setSearchTerm(String value) {
    searchTerm = value;
  }

  @observable
  ObservableList<Employee> employeeList = ObservableList<Employee>.of([]);

  @action
  Future<bool> getEmployeeData() async {
    employeeList.clear();
    int dbCount = await _repository.getCount();
    print('dbCount');
    print(dbCount);

    /// if employee data is not stored in db then call api
    if (dbCount == 0) {
      await _repository.getEmployees().then((value) async {
        EmployeeList empList = await _repository.getAllEmployeesFromDb();
        print('employees from db');
        print(empList.employees!.length);
        for (int i = 0; i < empList.employees!.length; i++) {
          // print(empList.employees![i].name);
          employeeList.add(empList.employees![i]);
        }
      }).catchError(
        (error) {
          loading = false;
          throw error;
        },
      );
    } else {
      EmployeeList empList = await _repository.getAllEmployeesFromDb();
      for (int i = 0; i < empList.employees!.length; i++) {
        employeeList.add(empList.employees![i]);
      }
    }
    loading = false;
    return false;
  }

  @action
  Future searchByName(String filter) async {
    print('filter');
    print(filter);
    employeeList.clear();
    List<Employee> empList = await _repository.findEmployeeByName(filter);
    print('empList');
    print(empList.length);
    for (int i = 0; i < empList.length; i++) {
      employeeList.add(empList[i]);
    }
  }

  @action
  Future searchByEmail(String filter) async {
    employeeList.clear();
    List<Employee> empList = await _repository.findEmployeeByEmail(filter);
    print('empList');
    print(empList.length);
    for (int i = 0; i < empList.length; i++) {
      employeeList.add(empList[i]);
    }
  }

  // general methods:-----------------------------------------------------------
  @action
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
