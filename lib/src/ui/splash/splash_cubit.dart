import 'package:employee_demo/app_routes/app_routes.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigation.instance.popAllAndPushName(AppRoutes.employeeListView);
  }
}
