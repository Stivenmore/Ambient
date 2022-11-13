import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/cubit/howtoprepared/howtoprepared_cubit.dart';
import 'package:ambient/domain/models/howtoprepared_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/home/HowToPrepared/widgets/sample_player.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HowtopreparedScreen extends StatefulWidget {
  const HowtopreparedScreen({super.key});

  @override
  State<HowtopreparedScreen> createState() => _HowtopreparedScreenState();
}

class _HowtopreparedScreenState extends State<HowtopreparedScreen> {
  Map map = {0: "All", 1: "Plastico", 2: "Papel", 3: "Carton", 4: "Metal"};
  int value = 0;

  @override
  void initState() {
    context.read<HowtopreparedCubit>().getAllHowToprepared();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationCubit = context.read<GeneralCubit>();
    Responsive responsive = Responsive(context);
    return WillPopScope(
        onWillPop: () async {
          navigationCubit.lastnavigation();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: UniCodes.whiteperformance,
            leading: IconButton(
                onPressed: () {
                  navigationCubit.lastnavigation();
                  NavigatorManager.ofPoPFadeTrasition(context: context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: UniCodes.cielbenefics,
                )),
            title: Text(
              "Como preparar el reciclaje",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                color: UniCodes.cielbenefics,
              )),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            height: responsive.height,
            width: responsive.width,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: responsive.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: map.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: value != index
                                ? () {
                                    setState(() {
                                      value = index;
                                    });
                                    if (value == 0) {
                                      context
                                          .read<HowtopreparedCubit>()
                                          .getAllHowToprepared();
                                    } else {
                                      context
                                          .read<HowtopreparedCubit>()
                                          .getForTypeHowToprepared(map[value]
                                              .toString()
                                              .toLowerCase());
                                    }
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: value == index
                                        ? UniCodes.blueperformance
                                        : UniCodes.whiteperformance,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    " ${map[index]} ",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                      color: value == index
                                          ? UniCodes.whiteperformance
                                          : UniCodes.blueperformance,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: responsive.height - 200,
                  width: responsive.width,
                  child: BlocBuilder<HowtopreparedCubit, HowtopreparedState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case HowtopreparedLoaded:
                          List<HowToPreparedModel> list =
                              state.props[0] as List<HowToPreparedModel>;
                          if (list.isNotEmpty) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return CardPrepared(
                                      responsive: responsive,
                                      list: list[index]);
                                });
                          } else {
                            return SizedBox(
                              height: responsive.hp(50),
                              width: responsive.width,
                              child: const Center(child: Text("Sin contenido")),
                            );
                          }
                        case HowtopreparedLoading:
                          return ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade100,
                                  child: CardPrepared(
                                      responsive: responsive,
                                      list: HowToPreparedModel(
                                          name: "",
                                          time: "",
                                          url: "",
                                          type: "")),
                                );
                              });
                        case HowtopreparedError:
                          return SizedBox(
                            height: responsive.hp(50),
                            width: responsive.width,
                            child: const Center(child: Text("Error")),
                          );
                        default:
                          return ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade100,
                                  child: CardPrepared(
                                      responsive: responsive,
                                      list: HowToPreparedModel(
                                          name: "",
                                          time: "",
                                          url: "",
                                          type: "")),
                                );
                              });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CardPrepared extends StatelessWidget {
  const CardPrepared({
    Key? key,
    required this.responsive,
    required this.list,
  }) : super(key: key);

  final Responsive responsive;
  final HowToPreparedModel list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: responsive.width,
          decoration: BoxDecoration(color: UniCodes.gray1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 5,
                    decoration: BoxDecoration(
                      color: UniCodes.cielbenefics,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: responsive.wp(50),
                          child: Text(
                            list.name,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: UniCodes.blueblack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          list.time,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: UniCodes.blueblack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  NavigatorManager.pushFadeTransition(
                      context: context, page: SamplePlayer(url: list.url));
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                          color: UniCodes.cielbenefics,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Ver",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: UniCodes.whiteperformance,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
