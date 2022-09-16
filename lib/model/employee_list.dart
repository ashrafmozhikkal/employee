import 'employee_model.dart';

class EmployeeList {
  final List<Employee>? employees;

  EmployeeList({
    this.employees,
  });

  factory EmployeeList.fromJson(List<dynamic> json) {
    List<Employee>? emps = <Employee>[];
    emps = json.map((emp) => Employee.fromJson(emp)).toList();

    return EmployeeList(
      employees: emps,
    );
  }
}
