import 'package:employee/stores/employee_store.dart';
import 'package:employee/ui/employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../model/employee_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Future<void> didChangeDependencies() async {
    _employeeStore = Provider.of<EmployeeStore>(context);
    if (!changed) {
      await _employeeStore.getEmployeeData();
      changed = true;
    }
    super.didChangeDependencies();
  }

  bool changed = false;
  late EmployeeStore _employeeStore;
  TextEditingController searchNameController = TextEditingController();
  TextEditingController searchEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Data'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchNameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _employeeStore.setSearchTerm(value);
                _employeeStore.searchByName(_employeeStore.searchTerm);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchEmailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _employeeStore.setSearchTerm(value);
                _employeeStore.searchByEmail(_employeeStore.searchTerm);
              },
            ),
          ),
          Row(
            children: const [
              SizedBox(
                width: 120,
              ),
              SizedBox(
                  width: 150,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                  width: 100,
                  child: Text(
                    'Company Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          const Divider(
            thickness: 5,
          ),
          Expanded(
            child: Observer(
              builder: (_) => ListView.builder(
                  itemCount: _employeeStore.employeeList.length,
                  itemBuilder: (context, index) {
                    return employeeView(_employeeStore.employeeList[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  employeeView(Employee employee) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmployeeView(employee: employee)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            employee.profileImage == null
                ? Image.asset(
                    'assets/images/noImage.jpg',
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  )
                : Image.network(
                    employee.profileImage!,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: SizedBox(width: 150, child: Text('${employee.name}')),
            ),
            SizedBox(
              width: 100,
              child: employee.company == null
                  ? const Text('NA')
                  : Text('${employee.company!.name}'),
            ),
          ],
        ),
      ),
    );
  }
}
