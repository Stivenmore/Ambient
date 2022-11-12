import 'package:ambient/domain/cubit/benefics/benefics_cubit.dart';
import 'package:ambient/screens/home/Benefics/widgets/calculatesuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CalculatePoint extends StatefulWidget {
  const CalculatePoint({super.key});

  @override
  State<CalculatePoint> createState() => _CalculatePointState();
}

class _CalculatePointState extends State<CalculatePoint> {
  @override
  Widget build(BuildContext context) {
    BeneficsState resp = context.watch<BeneficsCubit>().state;
    switch (resp.configModelEnum) {
      case ConfigModelEnum.loading:
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: const CalculateSuccess(),
        );
      case ConfigModelEnum.success:
        return const CalculateSuccess();
      default:
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade100,
          child: const CalculateSuccess(),
        );
    }
  }
}
