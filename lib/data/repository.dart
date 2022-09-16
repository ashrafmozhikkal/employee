import 'dart:async';

import 'package:employee/data/local/constants/db_constants.dart';
import 'package:employee/data/sharedpref/shared_preference_helper.dart';
import 'package:employee/model/employee_list.dart';
import 'package:sembast/sembast.dart';

import '../model/employee_model.dart';
import 'local/datasources/post/post_datasource.dart';
import 'network/apis/posts/post_api.dart';

class Repository {
  // data source object
  final LocalDataSource _postDataSource;

  // api objects
  final PostApi _postApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._sharedPrefsHelper, this._postDataSource);

  // Post: ---------------------------------------------------------------------
  Future<dynamic> getEmployees() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getEmployees().then((employeeList) {
      print('employees');
      print(employeeList.employees!.length);
      employeeList.employees?.forEach((emp) {
        _postDataSource.insert(emp);
      });
      print('db count');
      print(_postDataSource.count());

      return employeeList;
    }).catchError((error) => throw error);
  }

  Future<List<Employee>> findEmployeeByName(String name) {
    List<Filter> filters = [];
    Filter nameFilter = Filter.matches(DBConstants.employeeName, name);
    // Filter emailFilter = Filter.equals(DBConstants.emailID, name);
    filters.add(nameFilter);
    // filters.add(emailFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((emp) => emp)
        .catchError((error) => throw error);
  }

  Future<List<Employee>> findEmployeeByEmail(String name) {
    List<Filter> filters = [];
    Filter emailFilter = Filter.matches(DBConstants.emailID, name);
    filters.add(emailFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((emp) => emp)
        .catchError((error) => throw error);
  }

  Future<EmployeeList> getAllEmployeesFromDb() {
    return _postDataSource.getDataFromDb();
  }

  Future<int> insert(Employee emp) => _postDataSource
      .insert(emp)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Employee emp) => _postDataSource
      .update(emp)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Employee emp) => _postDataSource
      .update(emp)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> getCount() => _postDataSource
      .count()
      .then((id) => id)
      .catchError((error) => throw error);
}
