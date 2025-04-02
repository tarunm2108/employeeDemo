import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial());

  List<String> role = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];

  final nameCtrl = TextEditingController();
  final roleCtrl = TextEditingController();
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();

  void showRoleDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))
        ),
        builder: (_) {
          return ListView.separated(
            itemBuilder: (_, index) {
              return InkWell(
                onTap: (){
                  Navigation.instance.pop();
                  roleCtrl.text = role[index];
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    role[index],
                    style: const TextStyle().regular.copyWith(
                      color: AppColors.color323238,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => Divider(
              height: 0,
              thickness: 1,
              color: AppColors.colorF2F2F2,
            ),
            itemCount: role.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
          );
        });
  }
}
