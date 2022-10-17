import 'package:ambient/domain/cubit/recomendations/recomendations_cubit.dart';
import 'package:ambient/domain/models/recomendations_model.dart';
import 'package:ambient/screens/home/Home/Recomendations/Widgets/recomendationsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendationsList extends StatelessWidget {
  const RecomendationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: BlocBuilder<RecomendationsCubit, RecomendationsState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case RecomendationsLoading:
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Color(0xff0A2D65),
                  ),
                ),
              );
            case RecomendationsError:
              return const Center(
                child: Text("Sin recomendaciones"),
              );
            case RecomendationsSuccess:
              List<RecomendationsModel> list =
                  state.props[0] as List<RecomendationsModel>;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return RecomendationCard(list: list[index]);
                  });
            default:
              return const SliverToBoxAdapter(child: SizedBox());
          }
        },
      ),
    );
  }
}
