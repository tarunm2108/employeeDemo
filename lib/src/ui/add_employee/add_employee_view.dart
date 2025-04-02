import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:employee_demo/app_const/app_assets.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/src/ui/add_employee/add_employee_cubit.dart';
import 'package:employee_demo/src/widgets/app_bar_widget.dart';
import 'package:employee_demo/src/widgets/app_scaffold.dart';
import 'package:employee_demo/src/widgets/app_text_field_widget.dart';
import 'package:employee_demo/src/widgets/svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeCubit(),
      child: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = context.read<AddEmployeeCubit>();
          return AppScaffold(
              appBar: AppBarWidget(
                title: AppStrings.instance.addEmployeeDetails,
              ),
              body: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextFieldWidget(
                      controller: cubit.nameCtrl,
                      hintText: AppStrings.instance.employeeName,
                      validator: (value) => FormFieldValidator.call(),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 12),
                        child: SvgImageWidget(
                          source: AppAssets.icPerson,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
