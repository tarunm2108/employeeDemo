import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/app_routes/app_routes.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/service/db_helper.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial());
  String groupByMonth = "";

  Future<void> init() async {
    final list = await DatabaseHelper.instance.getEmployees();
    list.sort((a, b) => DateFormat("dd MMM yyyy")
        .parse(b.startDate ?? '')
        .compareTo(DateFormat("dd MMM yyyy").parse(a.startDate ?? '')));
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
    if (lastState.employeeList?.isNotEmpty ?? false) {
      emit(EmployeeListLoaded(employeeList: lastState.employeeList));
    } else {
      emit(EmployeeListNoData());
    }
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
            duration: const Duration(seconds: 3),
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
              role: item?.role,
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
    final result = await Navigation.instance
        .navigateTo(AppRoutes.addEmployeeView, arg: item);
    if (result != null && result) {
      init();
    }
  }

  String getSeparateDate(String? date, int index) {
    if (date == null) {
      return "";
    }
    final startDate = DateFormat("dd MMM yyyy").parse(date);
    final lastState = state as EmployeeListLoaded;
    if (index == 0) {
      return DateFormat("MMMM yyyy").format(startDate);
    } else {
      int previousIndex = index - 1;
      final preDate = DateFormat("dd MMM yyyy")
          .parse(lastState.employeeList?[previousIndex].startDate ?? '');
      if (DateFormat("MMMM yyyy").format(startDate).toLowerCase() ==
          DateFormat("MMMM yyyy").format(preDate).toLowerCase()) {
        return '';
      }
      return DateFormat("MMMM yyyy").format(startDate);
    }
  }
}
