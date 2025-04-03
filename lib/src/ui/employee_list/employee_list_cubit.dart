import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/app_routes/app_routes.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/service/db_helper.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
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

  Future<void> addEmployeeTap() async {
    final result =
        await Navigation.instance.navigateTo(AppRoutes.addEmployeeView);
    if (result != null && result) {
      init();
    }
  }

  void deleteEmployee(Employee? item, BuildContext context, index) {
    final lastState = state as EmployeeListLoaded;
    lastState.employeeList?.remove(item);
    emit(EmployeeListLoaded(employeeList: lastState.employeeList));
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(
              AppStrings.instance.employeeDataHasBeenDeleted,
              style: const TextStyle().regular.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            action: SnackBarAction(
              label: AppStrings.instance.undo,
              onPressed: () {},
              textColor: AppColors.color1DA1F2,
            ),
            duration: const Duration(seconds: 4),
          ),
        )
        .closed
        .then((reason) {
      if (reason == SnackBarClosedReason.action) {
        lastState.employeeList?.insert(
            index,
            Employee(
              id: item?.id,
              name: item?.name,
              startDate: item?.startDate,
              endDate: item?.endDate,
            ));
        emit(EmployeeListLoaded(employeeList: lastState.employeeList));
      } else {
        DatabaseHelper.instance.deleteEmployee(item?.id);
      }
    });
  }

  Future<void> onEmployeeTap(Employee? item) async {
    final result =
        await Navigation.instance.navigateTo(AppRoutes.addEmployeeView,arg: item);
    if (result != null && result) {
      init();
    }
  }
}
