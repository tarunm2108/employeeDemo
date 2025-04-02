import 'package:employee_demo/app_routes/app_routes.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/service/db_helper.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial());

  Future<void> init() async {
    final list = await DatabaseHelper.instance.getEmployees();
    if (list.isNotEmpty) {
      emit(EmployeeListLoaded(employeeList: list));
    } else {
      emit(EmployeeListNoData());
    }
  }

  void addEmployeeTap() {
    Navigation.instance.navigateTo(AppRoutes.addEmployeeView);
  }
}
