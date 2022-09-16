import 'package:sembast/sembast.dart';

import '../../../../model/employee_list.dart';
import '../../../../model/employee_model.dart';
import '../../constants/db_constants.dart';

class LocalDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _postsStore = intMapStoreFactory.store(DBConstants.storeName);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  LocalDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Employee emp) async {
    return await _postsStore.add(_db, emp.toJson());
  }

  Future<int> count() async {
    return await _postsStore.count(_db);
  }

  Future<List<Employee>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
      filter: filters != null ? Filter.and(filters) : null,
      // sortOrders: [SortOrder(DBConstants.fieldId)],
    );

    final recordSnapshots = await _postsStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final post = Employee.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      post.id = snapshot.key;
      return post;
    }).toList();
  }

  Future<EmployeeList> getDataFromDb() async {
    print('Loading from database');

    var employeeList;

    // fetching data
    final recordSnapshots = await _postsStore.find(
      _db,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if (recordSnapshots.isNotEmpty) {
      employeeList = EmployeeList(
          employees: recordSnapshots.map((snapshot) {
        final post = Employee.fromJson(snapshot.value);
        // An ID is a key of a record from the database.
        post.id = snapshot.key;
        return post;
      }).toList());
    }

    return employeeList;
  }

  Future<int> update(Employee emp) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(emp.id));
    return await _postsStore.update(
      _db,
      emp.toJson(),
      finder: finder,
    );
  }

  Future<int> delete(Employee emp) async {
    final finder = Finder(filter: Filter.byKey(emp.id));
    return await _postsStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _postsStore.drop(
      _db,
    );
  }
}
