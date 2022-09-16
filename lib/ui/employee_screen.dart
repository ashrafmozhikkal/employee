import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/employee_model.dart';
import '../stores/employee_store.dart';

class EmployeeView extends StatefulWidget {
  final Employee employee;

  const EmployeeView({Key? key, required this.employee}) : super(key: key);

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  bool changed = false;
  late EmployeeStore _employeeStore;

  @override
  Future<void> didChangeDependencies() async {
    _employeeStore = Provider.of<EmployeeStore>(context);
    if (!changed) {
      await _employeeStore.getEmployeeData();
      changed = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employee Details'),
        ),
        body: Column(
          children: [employeeView(widget.employee)],
        )

        // ListView.builder(
        //     itemCount: _employeeStore.employeeList.length,
        //     itemBuilder: (context, index) {
        //       return employeeView(_employeeStore.employeeList[index]);
        //     }),
        );
  }

  employeeView(Employee employee) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text('Name: '),
              Text('${employee.name}'),
            ],
          ),
          Row(
            children: [
              const Text('UserName: '),
              Text('${employee.username}'),
            ],
          ),
          Row(
            children: [
              const Text('Email: '),
              Text('${employee.email}'),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Address: '),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Street: ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: employee.address!.street!,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Suite: ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: employee.address!.suite!,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'City: ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: employee.address!.city!,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Zip code: ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: employee.address!.zipcode!,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Location: ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'latitude: ${employee.address!.geo!.lat!}  '
                              'longitude: ${employee.address!.geo!.lng!}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text('Phone: '),
              Text(employee.phone == null ? 'NA' : '${employee.phone}'),
            ],
          ),
          Row(
            children: [
              const Text('Website: '),
              InkWell(
                onTap: () {
                  launchUrl(
                    Uri.parse(employee.website!),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  '${employee.website}',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue.shade900),
                ),
              ),
              // if (!await launchUrl(
              // Uri.parse(mapUrl!),
              // mode: LaunchMode.externalApplication,
              // )) {
              // throw 'Could not launch $mapUrl';
              // }
            ],
          ),
          const Text(
            'Company Details: ',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          employee.company == null
              ? const Text('NA')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Name: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: employee.company!.name!,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Catchphrase: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: employee.company!.catchPhrase!,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'bs: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: employee.company!.bs!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          // : Text('${employee.company!.name}'),
        ],
      ),
    );
  }
}
