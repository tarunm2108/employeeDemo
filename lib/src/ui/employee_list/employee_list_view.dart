import 'package:employee_demo/app_const/app_assets.dart';
import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/src/ui/employee_list/employee_list_cubit.dart';
import 'package:employee_demo/src/widgets/app_bar_widget.dart';
import 'package:employee_demo/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListCubit()..init(),
      child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
        builder: (context, state) {
          return AppScaffold(
            isBusy: state is EmployeeListInitial,
            appBar: AppBarWidget(title: AppStrings.instance.employeeList),
            floatingAction: FloatingActionButton(
              onPressed: () {
                context.read<EmployeeListCubit>().addEmployeeTap();
              },
              backgroundColor: AppColors.color1DA1F2,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            body: state is EmployeeListInitial
                ? const Center()
                : state is EmployeeListNoData
                    ? Center(
                        child:
                            Image.asset(AppAssets.imgNoEmployee, height: 245),
                      )
                    : ListView.separated(
                        itemBuilder: (_, index) {
                          return Container();
                        },
                        separatorBuilder: (_, index) {
                          return Container();
                        },
                        itemCount: 10,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
          );
        },
      ),
    );
  }
}
