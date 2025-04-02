import 'package:employee_demo/src/ui/splash/splash_cubit.dart';
import 'package:employee_demo/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit()..init(),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          if (state is SplashInitial) {
            return const AppScaffold(
              body: Center(child: Text('Splash View')),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
