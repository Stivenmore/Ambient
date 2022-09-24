import 'package:ambient/domain/cubit/cubit/sign_in_and_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInAndUpCubit>();
    return Scaffold(
      body: Center(
        child: Text(cubit.usermodelCubit.nombre),
      ),
    );
  }
}
