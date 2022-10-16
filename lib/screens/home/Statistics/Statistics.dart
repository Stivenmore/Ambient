import 'dart:math';

import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/models/statistic_glob.dart';
import 'package:ambient/domain/models/statistic_obt.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const sliverPadding = SliverToBoxAdapter(
  child: SizedBox(
    height: 30,
  ),
);

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<StatisticGlobLocal> data = [];
  List<StatisticObjLocal> data2 = [];
  List colors = [
    const Color(0xff155BCD),
    const Color(0xff0A2D65),
    const Color(0xff85A9FF),
    const Color(0xffD7E2FE),
    const Color(0xff111132),
    const Color(0xff0F272E),
  ];
  @override
  void initState() {
    final cubit = context.read<SignInAndUpCubit>();
    cubit.usermodelCubit.statisticGlob.obj.forEach((element) {
      data.add(StatisticGlobLocal(
          name: element.split("-")[0],
          value: int.parse(element.split("-")[1]),
          value2: 0));
    });
    cubit.usermodelCubit.reciclajeObj.obj.forEach((element) {
      data2.add(StatisticObjLocal(
        name: element.split("-")[0],
        value: double.parse(element.split("-")[1]),
        value2: colors[!cubit.usermodelCubit.reciclajeObj.obj.contains(element)
            ? 0
            : cubit.usermodelCubit.reciclajeObj.obj.indexOf(element)],
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    final navigationCubit = context.read<GeneralCubit>();
    return WillPopScope(
      onWillPop: () async {
        navigationCubit.lastnavigation();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SizedBox(
            height: responsive.height,
            width: responsive.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      "Estadisticas",
                      style: GoogleFonts.montserrat(),
                    ),
                  ),
                  sliverPadding,
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26)),
                      height: 400,
                      width: responsive.wp(80),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Estadistica global",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Por mes",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.withOpacity(0.5)),
                            ),
                            SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  // Renders column chart
                                  RangeColumnSeries<StatisticGlobLocal, String>(
                                    dataSource: data,
                                    xValueMapper:
                                        (StatisticGlobLocal data, _) =>
                                            data.name,
                                    lowValueMapper:
                                        (StatisticGlobLocal data, _) =>
                                            data.value2,
                                    highValueMapper:
                                        (StatisticGlobLocal data, _) =>
                                            data.value,
                                  )
                                ])
                          ],
                        ),
                      ),
                    ),
                  ),
                  sliverPadding,
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26)),
                      height: 400,
                      width: responsive.wp(80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Ultima distribucion por fraccion",
                            style: GoogleFonts.montserrat(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 300,
                                  width: responsive.wp(15),
                                  child: ListView.builder(
                                      itemCount: data2.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 14,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: data2[index].value2),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(data2[index].name),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(
                                width: responsive.wp(60),
                                child: SfCircularChart(
                                  series: <CircularSeries>[
                                    DoughnutSeries<StatisticObjLocal, String>(
                                        dataSource: data2,
                                        pointColorMapper:
                                            (StatisticObjLocal data, _) =>
                                                data.value2,
                                        xValueMapper:
                                            (StatisticObjLocal data, _) =>
                                                data.name,
                                        yValueMapper:
                                            (StatisticObjLocal data, _) =>
                                                data.value,
                                        radius: "90%"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
