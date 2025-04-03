import 'package:employee_demo/app_const/app_assets.dart';
import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/service/db_helper.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:employee_demo/src/extensions/space_extension.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:employee_demo/src/ui/add_employee/add_edit_employee_view.dart';
import 'package:employee_demo/src/widgets/app_button_widget.dart';
import 'package:employee_demo/src/widgets/svg_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

part 'add_edit_employee_state.dart';

enum DateType { start, end }

class AddEditEmployeeCubit extends Cubit<AddEditEmployeeState> {
  AddEditEmployeeCubit() : super(AddEditEmployeeInitial());

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
  DateTime? startDate, endDate;
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey();
  Employee? arg;

  void init(Employee? arg) {
    this.arg = arg;
    if (arg != null) {
      nameCtrl.text = "${arg.name}";
      roleCtrl.text = "${arg.role}";
      startDateCtrl.text = "${arg.startDate}";
      endDateCtrl.text = "${arg.endDate}";
    }
  }

  Future<void> addEmployee() async {
    if (formKey.currentState?.validate() ?? false) {
      Employee employee = Employee(
        name: nameCtrl.text.trim(),
        role: roleCtrl.text.trim(),
        startDate: startDateCtrl.text.trim(),
        endDate: endDateCtrl.text.trim(),
      );
      if (arg != null) {
        await DatabaseHelper.instance.updateEmployee(employee);
      } else {
        await DatabaseHelper.instance.addEmployee(employee);
      }
      Navigation.instance.pop(result: true);
    }
  }

  void showRoleDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        builder: (_) {
          return ListView.separated(
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
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

  void showDatePicker(BuildContext context, DateType type) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                lastDate: DateTime(2050),
                onDateChanged: (date) {
                  if (type == DateType.start) {
                    startDate = date;
                    startDateCtrl.text = date.toString();
                  } else {
                    endDate = date;
                    endDateCtrl.text = date.toString();
                  }
                },
              ),
            ),
          );
        });
  }

  void showCalendar(BuildContext context, DateType type) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Today"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Next Monday"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Next Tuesday"),
                      ),
                      ElevatedButton(
                        onPressed: () => {},
                        child: const Text("After 1 week"),
                      ),
                    ],
                  ),
                ),
                24.toHeight,
                TableCalendar(
                  firstDay: DateTime(1970),
                  lastDay: DateTime.now(),
                  focusedDay: selectedDate,
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {},

                  calendarBuilders:
                      CalendarBuilders(headerTitleBuilder: (_, date) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgImageWidget(source: AppAssets.icCalendarPrevious),
                          12.toWidth,
                          Text(
                            DateFormat('dd MMM yyyy').format(date),
                            style: const TextStyle().regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: AppColors.color323238,
                                ),
                          ),
                          12.toWidth,
                          SvgImageWidget(source: AppAssets.icCalendarNext),
                          const Spacer(),
                        ],
                      ),
                    );
                  }),
                  headerStyle: const HeaderStyle(
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(

                  ),
                ),
                20.toHeight,
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.colorF2F2F2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgImageWidget(source: AppAssets.icCalendar),
                      12.toWidth,
                      Text(
                        DateFormat('dd MMM yyyy').format(selectedDate),
                        style: const TextStyle().regular.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.color323238,
                            ),
                      ),
                      const Spacer(),
                      AppButtonWidget(
                        onPressed: () => Navigation.instance.pop(),
                        title: AppStrings.instance.cancel,
                        width: 75,
                        textColor: AppColors.color1DA1F2,
                        bgColor: AppColors.colorEDF8FF,
                      ),
                      16.toWidth,
                      AppButtonWidget(
                        onPressed: () {},
                        title: AppStrings.instance.save,
                        width: 75,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
