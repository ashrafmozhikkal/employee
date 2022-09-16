import 'dart:async';

import 'package:employee/model/employee_list.dart';

import '../../constants/endpoints.dart';
import '../../dio_client.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PostApi(this._dioClient);

  /// Returns list of post in response
  Future<EmployeeList> getEmployees() async {
    try {
      final res = await _dioClient.get(Endpoints.getEmployees);
      return EmployeeList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
