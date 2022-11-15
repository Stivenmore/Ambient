import 'dart:ui';
import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:ambient/screens/Splash/splash.dart';
import 'package:ambient/screens/home/Account/Person/person_screen.dart';
import 'package:ambient/screens/home/Benefics/Benefics.dart';
import 'package:ambient/screens/home/Home/home.dart';
import 'package:ambient/screens/home/HowToPrepared/Howtoprepared.dart';
import 'package:ambient/screens/home/Statistics/Statistics.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigatorManager {
  static void pushFadeTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.bounceIn);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void pushSliderTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: const Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void inTopushFadeTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return page;
          },
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        ((route) => true));
  }

  static void pushAndRemoveFadeTransition(
      {required BuildContext context, required Widget page}) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return page;
          },
          transitionDuration: const Duration(milliseconds: 5000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        ((route) => false));
  }

  static void ofPoPFadeTrasition({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  void pushAlertDialogManager(
      GeneralCubit cubit, SignInAndUpCubit signInAndUpCubit,
      {required BuildContext context}) {
    Responsive responsive = Responsive(context);
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 0,
              backgroundColor: Colors.white,
              alignment: const Alignment(-2.5, 0),
              child: SizedBox(
                height: responsive.height * .9,
                width: responsive.width * .75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CardWidget(userModel: cubit.usermodelCubit),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: responsive.hp(35),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (cubit.currentNavigation != index) {
                                        cubit.currentNavigation = index;
                                        Navigator.of(context).pop();
                                        NavigatorManager.inTopushFadeTransition(
                                            context: context,
                                            page: options[index]["page"]);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: responsive.wp(55),
                                      height: 62,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: cubit.currentNavigation ==
                                                  options[index]["position"]
                                              ? Colors.grey[850]
                                              : Colors.white),
                                      child: Row(
                                        children: [
                                          Icon(
                                            options[index]["icon"],
                                            color: cubit.currentNavigation ==
                                                    options[index]["position"]
                                                ? Colors.white
                                                : Colors.grey[700],
                                          ),
                                          const SizedBox(
                                            width: 28,
                                          ),
                                          Text(options[index]["name"],
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                      color:
                                                          cubit.currentNavigation ==
                                                                  options[index]
                                                                      [
                                                                      "position"]
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[700],
                                                      fontSize: 16))),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          signInAndUpCubit.signOutMethod();
                          NavigatorManager.inTopushFadeTransition(
                              context: context, page: const SplashScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Cerrar sesion",
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey[700],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CardWidget extends StatelessWidget {
  final UserModel userModel;
  const CardWidget({
    required this.userModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorManager.pushFadeTransition(
            context: context, page: UserScreen(userModel: userModel));
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.person,
                color: Colors.grey[700],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.nombre.substring(
                        0,
                        userModel.nombre.length >= 24
                            ? (24 - 1)
                            : userModel.nombre.length),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    userModel.email,
                    maxLines: 1,
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_drop_down_outlined))
          ],
        ),
      ),
    );
  }
}

List<Map> options = [
  {
    "icon": Icons.home,
    "name": "Inicio",
    "position": 0,
    "page": const HomeScreen(),
  },
  {
    "icon": Icons.star,
    "name": "Beneficios",
    "position": 1,
    "page": const BeneficsScreen()
  },
  {
    "icon": Icons.balance,
    "name": "Estadisticas",
    "position": 2,
    "page": const StatisticsScreen()
  },
  {
    "icon": Icons.recycling,
    "name": "Preparar el reciclaje",
    "position": 3,
    "page": const HowtopreparedScreen()
  }
];
