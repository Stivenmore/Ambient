import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/cubit/recomendations/recomendations_cubit.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/home/Home/Recomendations/recomendationsList.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String saludo;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<RecomendationsCubit>().getRecomendations();
    });
    timeSaludo();
    super.initState();
  }

  void timeSaludo() {
    if (DateTime.now().hour > 4 && DateTime.now().hour < 12) {
      saludo = "Buenos dias!";
    } else if (DateTime.now().hour == 12 && DateTime.now().hour < 18) {
      saludo = "Buenas tardes!";
    } else {
      saludo = "Buenas noches!";
    }
  }

  String nameUser(SignInAndUpCubit cubit) {
    String name = cubit.usermodelCubit.nombre.split(" ")[0];
    String firstLast = cubit.usermodelCubit.nombre.split(" ").length > 1
        ? cubit.usermodelCubit.nombre
            .split(" ")[1]
            .substring(0, 1)
            .toUpperCase()
        : "";
    String lastname = cubit.usermodelCubit.nombre.split(" ").length > 1
        ? cubit.usermodelCubit.nombre
            .split(" ")[1]
            .substring(1, cubit.usermodelCubit.nombre.split(" ")[1].length)
        : "";
    return "$name $firstLast$lastname";
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    GeneralCubit generalCubit = context.watch<GeneralCubit>();
    SignInAndUpCubit signInAndUpCubit = context.read<SignInAndUpCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            saludo,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            nameUser(signInAndUpCubit),
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18)),
                          )
                        ],
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(right: 25),
                        icon: const Icon(
                          Icons.auto_awesome_mosaic_sharp,
                          color: Color(0xff0A2D65),
                        ),
                        onPressed: () {
                          NavigatorManager().pushAlertDialogManager(
                              generalCubit, signInAndUpCubit,
                              context: context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recomendaciones",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black87.withOpacity(0.7),
                                fontWeight: FontWeight.w700,
                                fontSize: 17)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
              const SliverToBoxAdapter(
                child: RecomendationsList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
