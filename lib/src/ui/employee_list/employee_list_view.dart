import 'package:employee_demo/app_const/app_assets.dart';
import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/src/extensions/space_extension.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:employee_demo/src/ui/employee_list/employee_list_cubit.dart';
import 'package:employee_demo/src/widgets/app_bar_widget.dart';
import 'package:employee_demo/src/widgets/app_scaffold.dart';
import 'package:employee_demo/src/widgets/svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListCubit()..init(),
      child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
        builder: (context, state) {
          return AppScaffold(
            bgColor: AppColors.colorF2F2F2,
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
            body: _body(state, context),
          );
        },
      ),
    );
  }
}

Widget _body(EmployeeListState state, BuildContext context) {
  if (state is EmployeeListLoaded) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView.separated(
                itemBuilder: (_, index) {
                  final item = state.employeeList?[index];
                  return _listItem(item, index, context);
                },
                separatorBuilder: (_, index) {
                  return Divider(
                    color: AppColors.colorF2F2F2,
                    height: 0,
                    thickness: 1,
                  );
                },
                itemCount: state.employeeList?.length ?? 0,
                shrinkWrap: true,
                padding: EdgeInsets.zero),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          child: Text(
            AppStrings.instance.swipeLeftToDelete,
            style: const TextStyle().regular.copyWith(
                  color: AppColors.color949C9E,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
          ),
        )
      ],
    );
  } else if (state is EmployeeListNoData) {
    return Center(
      child: Image.asset(AppAssets.imgNoEmployee, height: 245),
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget _listItem(Employee? item, int index, BuildContext context) {
  final separator =
      context.read<EmployeeListCubit>().getSeparateDate(item?.startDate,index);
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      separator.isNotEmpty
          ? Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(color: AppColors.colorE5E5E5),
              child: Text(
                separator,
                style: const TextStyle().regular.copyWith(
                      color: AppColors.color1DA1F2,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
              ),
            )
          : const SizedBox.shrink(),
      Slidable(
        key: ValueKey(index),
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.2,
          children: [
            CustomSlidableAction(
              onPressed: (_) {
                context
                    .read<EmployeeListCubit>()
                    .deleteEmployee(item, context, index);
              },
              backgroundColor: AppColors.colorF34642,
              autoClose: true,
              child: SvgImageWidget(source: AppAssets.icDelete, height: 21),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            context.read<EmployeeListCubit>().onEmployeeTap(item);
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.name ?? "Employee",
                  style: const TextStyle().bold.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.color323238,
                      ),
                ),
                6.toHeight,
                Text(
                  item?.role ?? "N/A",
                  style: const TextStyle().regular.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.color949C9E,
                      ),
                ),
                6.toHeight,
                Text(
                  "From ${item?.startDate ?? AppStrings.instance.noDate}",
                  style: const TextStyle().bold.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.color949C9E,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
