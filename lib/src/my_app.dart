import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/app_cubit/app_cubit.dart';
import 'package:employee_demo/app_routes/app_routes.dart';
import 'package:employee_demo/app_const/app_strings.dart';
import 'package:employee_demo/service/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..init(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppStrings.instance.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    onPrimary: AppColors.color1DA1F2,
                  ),
              fontFamily: "roboto",
              scaffoldBackgroundColor: AppColors.colorF2F2F2,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(
                color: AppColors.color1DA1F2,
              ),
            ),
            routes: AppRoutes.routes,
            initialRoute: AppRoutes.splashView,
            navigatorKey: Navigation.instance.navigatorKey,
          );
        },
      ),
    );
  }
}
