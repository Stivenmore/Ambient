import 'dart:ui';

import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    GeneralCubit cubit = context.watch<GeneralCubit>();
    SignInAndUpCubit cubit2 = context.read<SignInAndUpCubit>();
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: responsive.height,
      width: responsive.width,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            actions: [
              FloatingActionButton(
                elevation: 0.0,
                onPressed: () {
                  NavigatorManager()
                      .pushAlertDialogManager(cubit, cubit2, context: context);
                },
                child: const Icon(Icons.person),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: 200,
              color: Colors.purple,
            ),
          )
        ],
      ),
    );
  }
}
