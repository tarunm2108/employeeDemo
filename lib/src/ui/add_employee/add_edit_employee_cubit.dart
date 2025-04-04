import 'package:employee_demo/app_const/app_assets.dart';
import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/service/db_helper.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:employee_demo/src/extensions/space_extension.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:employee_demo/src/widgets/app_button_widget.dart';
import 'package:employee_demo/src/widgets/svg_image_widget.dart';
import 'package:employee_demo/utils/utility.dart';
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
  DateTime selectedDate = DateTime.now(),
      minDate = DateTime(1970, 1, 1),
      maxDate = DateTime(2070, 12, 31);
  final GlobalKey<FormState> formKey = GlobalKey();
  late PageController _pageController;
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
        employee.id = arg!.id;
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

  void showCalendar(BuildContext context, DateType type) {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      type == DateType.start
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: AppButtonWidget(
                                        onPressed: () {
                                          selectedDate = DateTime.now();
                                          setState(() {});
                                        },
                                        title: AppStrings.instance.today,
                                        textColor:
                                            selectedDate == DateTime.now()
                                                ? null
                                                : AppColors.color1DA1F2,
                                        bgColor: selectedDate == DateTime.now()
                                            ? null
                                            : AppColors.colorEDF8FF,
                                        style:
                                            const TextStyle().regular.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.color1DA1F2,
                                                ),
                                      ),
                                    ),
                                    16.toWidth,
                                    Expanded(
                                      flex: 1,
                                      child: AppButtonWidget(
                                        onPressed: () {
                                          getNextWeekday(1);
                                          setState(() {});
                                        },
                                        title: AppStrings.instance.nextMonday,
                                        style:
                                            const TextStyle().regular.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                      ),
                                    ),
                                  ],
                                ),
                                16.toHeight,
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: AppButtonWidget(
                                        onPressed: () {
                                          getNextWeekday(2);
                                          setState(() {});
                                        },
                                        title: AppStrings.instance.nextTuesday,
                                        textColor: AppColors.color1DA1F2,
                                        bgColor: AppColors.colorEDF8FF,
                                        style:
                                            const TextStyle().regular.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.color1DA1F2,
                                                ),
                                      ),
                                    ),
                                    16.toWidth,
                                    Expanded(
                                      flex: 1,
                                      child: AppButtonWidget(
                                        onPressed: () {
                                          final date = DateTime.now()
                                              .add(const Duration(days: 7));
                                          if (date.isAfter(minDate) &&
                                              date.isBefore(maxDate)) {
                                            selectedDate = date;
                                            setState(() {});
                                          }
                                        },
                                        title: AppStrings.instance.afterOneWeek,
                                        textColor: AppColors.color1DA1F2,
                                        bgColor: AppColors.colorEDF8FF,
                                        style:
                                            const TextStyle().regular.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: AppColors.color1DA1F2,
                                                ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: AppButtonWidget(
                                    onPressed: () {
                                      setState(() {});
                                    },
                                    title: AppStrings.instance.noDate,
                                    style: const TextStyle().regular.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                16.toWidth,
                                Expanded(
                                  flex: 1,
                                  child: AppButtonWidget(
                                    onPressed: () {
                                      selectedDate = DateTime.now();
                                      setState(() {});
                                    },
                                    title: AppStrings.instance.today,
                                    textColor: AppColors.color1DA1F2,
                                    bgColor: AppColors.colorEDF8FF,
                                    style: const TextStyle().regular.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColors.color1DA1F2,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                24.toHeight,
                TableCalendar(
                  firstDay: minDate,
                  lastDay: maxDate,
                  focusedDay: selectedDate,
                  // currentDay: selectedDate,
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    selectedDate = selectedDay;
                    setState(() {});
                  },
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (_, date) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                _goToPreviousMonth();
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgImageWidget(
                                    source: AppAssets.icCalendarPrevious),
                              ),
                            ),
                            Text(
                              DateFormat('MMMM yyyy').format(date),
                              style: const TextStyle().regular.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.color323238,
                                  ),
                            ),
                            InkWell(
                              onTap: () {
                                _goToNextMonth();
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgImageWidget(
                                    source: AppAssets.icCalendarNext),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      );
                    },
                  ),
                  headerStyle: const HeaderStyle(
                    leftChevronVisible: false,
                    rightChevronVisible: false,
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(),
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.color1DA1F2, width: 1),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.color1DA1F2,
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: const TextStyle().regular.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color323238),
                      todayTextStyle: const TextStyle().regular.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color323238),
                      tablePadding: const EdgeInsets.symmetric(horizontal: 16)),
                  onCalendarCreated: (controller) =>
                      _pageController = controller,
                ),
                20.toHeight,
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.colorF2F2F2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                        onPressed: () {
                          if (type == DateType.start) {
                            startDate = selectedDate;
                            startDateCtrl.text =
                                DateFormat('dd MMM yyyy').format(selectedDate);
                          } else {
                            if (startDate != null &&
                                selectedDate.isBefore(startDate!)) {
                              Navigation.instance.pop();
                              Utility.showToast(context,
                                  AppStrings.instance.pleaseSelectValidDate);
                              return;
                            }
                            endDate = selectedDate;
                            endDateCtrl.text =
                                DateFormat('dd MMM yyyy').format(selectedDate);
                          }
                          Navigation.instance.pop();
                        },
                        title: AppStrings.instance.save,
                        width: 75,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        );
      },
    );
  }

  void _goToPreviousMonth() {
    final prevMonth = DateTime(selectedDate.year, selectedDate.month - 1);
    if (prevMonth.isAfter(minDate)) {
      selectedDate = prevMonth;
      _pageController.animateToPage(
        _pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextMonth() {
    final nextMonth = DateTime(selectedDate.year, selectedDate.month + 1);
    if (nextMonth.isBefore(maxDate)) {
      selectedDate = nextMonth;
      _pageController.animateToPage(
        _pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void getNextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysUntilNext = (weekday - now.weekday + 7) % 7;
    final date =
        now.add(Duration(days: daysUntilNext == 0 ? 7 : daysUntilNext));
    if (date.isAfter(minDate) && date.isBefore(maxDate)) {
      selectedDate = date;
    }
  }
}
