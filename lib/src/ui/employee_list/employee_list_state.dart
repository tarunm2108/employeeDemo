part of 'employee_list_cubit.dart';

@immutable
sealed class EmployeeListState {}

final class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final List<Employee>? employeeList;

  EmployeeListLoaded({this.employeeList});

  EmployeeListLoaded copyWith({
    List<Employee>? employeeList,
  }) {
    return EmployeeListLoaded(
      employeeList: employeeList ?? this.employeeList,
    );
  }
}

final class EmployeeListNoData extends EmployeeListState {}
