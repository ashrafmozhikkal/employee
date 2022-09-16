import 'package:employee/stores/employee_store.dart';
import 'package:employee/ui/home_screen.dart';
import 'package:employee/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'data/repository.dart';
import 'di/components/service_locator.dart';

class MyApp extends StatelessWidget {
  final EmployeeStore _empStore = EmployeeStore(getIt<Repository>());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EmployeeStore>(create: (_) => _empStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Employee db',
            routes: Routes.routes,
            // localizationsDelegates: const [
            //   // A class which loads the translations from JSON files
            //   AppLocalizations.delegate,
            //   // Built-in localization of basic text for Material widgets
            //   GlobalMaterialLocalizations.delegate,
            //   // Built-in localization for text direction LTR/RTL
            //   GlobalWidgetsLocalizations.delegate,
            //   // Built-in localization of basic text for Cupertino widgets
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
