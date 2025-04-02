import 'package:employee_demo/src/ui/add_employee/add_employee_view.dart';
import 'package:employee_demo/src/ui/employee_list/employee_list_view.dart';
import 'package:employee_demo/src/ui/splash/splash_view.dart';

class AppRoutes {
  static const splashView = '/';
  static const employeeListView = '/employeeListView';
  static const addEmployeeView = '/addEmployeeView';

  static final routes = {
    splashView: (context) => const SplashView(),
    employeeListView: (context) => const EmployeeListView(),
    addEmployeeView: (context) => const AddEmployeeView(),
  };
}
