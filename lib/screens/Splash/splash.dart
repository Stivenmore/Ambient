import 'package:ambient/domain/cubit/splash/splash_cubit.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/Autenticate/Login.dart';
import 'package:ambient/screens/home/Home/home.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<SplashCubit>().getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case SplashSuccess:
            NavigatorManager.pushAndRemoveFadeTransition(
                context: context, page: const HomeScreen());
            break;
          case SplashError:
            NavigatorManager.pushAndRemoveFadeTransition(
                context: context, page: const Login());
            break;
          default:
        }
      },
      child: SizedBox(
        height: responsive.height,
        width: responsive.width,
        child: Center(
          child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 15.0),
              duration: const Duration(seconds: 10),
              builder: (context, double value, child) {
                return Transform.rotate(
                  angle: value,
                  child: const Icon(
                    Icons.star,
                    color: Colors.purple,
                    size: 28,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
