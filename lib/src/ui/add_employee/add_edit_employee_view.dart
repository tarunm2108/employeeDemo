import 'package:employee_demo/app_const/app_assets.dart';
import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:employee_demo/src/extensions/space_extension.dart';
import 'package:employee_demo/src/ui/add_employee/add_edit_employee_cubit.dart';
import 'package:employee_demo/src/widgets/app_bar_widget.dart';
import 'package:employee_demo/src/widgets/app_button_widget.dart';
import 'package:employee_demo/src/widgets/app_scaffold.dart';
import 'package:employee_demo/src/widgets/app_text_field_widget.dart';
import 'package:employee_demo/src/widgets/svg_image_widget.dart';
import 'package:employee_demo/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditEmployeeView extends StatelessWidget {
  const AddEditEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Employee?;
    return BlocProvider(
      create: (context) => AddEditEmployeeCubit()..init(arg),
      child: BlocBuilder<AddEditEmployeeCubit, AddEditEmployeeState>(
        builder: (context, state) {
          final cubit = context.read<AddEditEmployeeCubit>();
          return AppScaffold(
            appBar: AppBarWidget(
              title: cubit.arg != null
                  ? AppStrings.instance.editEmployeeDetails
                  : AppStrings.instance.addEmployeeDetails,
            ),
            bottomWidget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(
                    color: AppColors.colorF2F2F2,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButtonWidget(
                    onPressed: () => Navigation.instance.pop(),
                    title: AppStrings.instance.cancel,
                    width: 75,
                    textColor: AppColors.color1DA1F2,
                    bgColor: AppColors.colorEDF8FF,
                  ),
                  16.toWidth,
                  AppButtonWidget(
                    onPressed: () => cubit.addEmployee(),
                    title: AppStrings.instance.save,
                    width: 75,
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Form(
                key: context.read<AddEditEmployeeCubit>().formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFieldWidget(
                      controller: cubit.nameCtrl,
                      hintText: AppStrings.instance.employeeName,
                      validator: Validator.instance.validField,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12),
                        child: SvgImageWidget(
                          source: AppAssets.icPerson,
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                    23.toHeight,
                    AppTextFieldWidget(
                      controller: cubit.roleCtrl,
                      hintText: AppStrings.instance.selectRole,
                      validator: Validator.instance.validField,
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12),
                        child: SvgImageWidget(
                          source: AppAssets.icRole,
                        ),
                      ),
                      readOnly: true,
                      onTap: () => cubit.showRoleDialog(context),
                      suffix: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12),
                        child: SvgImageWidget(
                          source: AppAssets.icDropdown,
                        ),
                      ),
                    ),
                    23.toHeight,
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: AppTextFieldWidget(
                            controller: cubit.startDateCtrl,
                            hintText: AppStrings.instance.noDate,
                            validator: Validator.instance.validField,
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 12),
                              child: SvgImageWidget(
                                source: AppAssets.icCalendar,
                              ),
                            ),
                            readOnly: true,
                            onTap: () =>
                                cubit.showDatePicker(context, DateType.start),
                          ),
                        ),
                        16.toWidth,
                        SvgImageWidget(
                          source: AppAssets.icArrowRight,
                          height: 12,
                        ),
                        16.toWidth,
                        Expanded(
                          flex: 1,
                          child: AppTextFieldWidget(
                            controller: cubit.endDateCtrl,
                            hintText: AppStrings.instance.noDate,
                            validator: Validator.instance.validField,
                            prefix: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 12),
                              child: SvgImageWidget(
                                source: AppAssets.icCalendar,
                              ),
                            ),
                            readOnly: true,
                            onTap: () =>
                                cubit.showCalendar(context, DateType.end),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
