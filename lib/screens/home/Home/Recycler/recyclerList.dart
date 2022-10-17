import 'package:ambient/domain/cubit/recycler/recycler_cubit.dart';
import 'package:ambient/domain/models/recycler_model.dart';
import 'package:ambient/screens/home/Home/Recycler/Widgets/recyclerCard.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RecyclerList extends StatelessWidget {
  const RecyclerList({
    Key? key,
    required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecyclerCubit, RecyclerState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RecyclerLoading:
            return const SliverToBoxAdapter(
              child: SizedBox(
                  child: Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Color(0xff0A2D65),
                  ),
                ),
              )),
            );
          case RecyclerError:
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("Sin recomendaciones"),
              ),
            );
          case RecyclerSuccess:
            List<RecyclerModel> recyclerList =
                state.props[0] as List<RecyclerModel>;
            return SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "Para recyclar",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black87.withOpacity(0.7),
                          fontWeight: FontWeight.w700,
                          fontSize: 17)),
                ),
                SizedBox(
                  height: responsive.hp(60),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: recyclerList.length,
                      itemBuilder: (context, index) {
                        return RecyclerCard(
                            responsive: responsive,
                            recyclerList: recyclerList[index]);
                      }),
                )
              ]),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
