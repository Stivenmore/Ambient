import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/cubit/benefics/benefics_cubit.dart';
import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/home/Benefics/widgets/calculatepoint.dart';
import 'package:ambient/screens/home/Benefics/widgets/list_transaction.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BeneficsScreen extends StatefulWidget {
  const BeneficsScreen({super.key});

  @override
  State<BeneficsScreen> createState() => _BeneficsScreenState();
}

class _BeneficsScreenState extends State<BeneficsScreen> {
  @override
  void initState() {
    context.read<BeneficsCubit>().getConfig();
    context.read<BeneficsCubit>().getStocks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usermodel = context.watch<SignInAndUpCubit>().usermodelCubit;
    Responsive responsive = Responsive(context);
    final navigationCubit = context.read<GeneralCubit>();
    return WillPopScope(
      onWillPop: () async {
        navigationCubit.lastnavigation();
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                navigationCubit.lastnavigation();
                                NavigatorManager.ofPoPFadeTrasition(
                                    context: context);
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Puntos actuales: ",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "${usermodel.transaction.last.point.toString()}P",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: UniCodes.cielbenefics,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                )),
                const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CalculatePoint(),
                )),
                if (usermodel.transaction.isNotEmpty)
                  ListTransation(
                    transaction: usermodel.transaction,
                  ),
                if (usermodel.transaction.isEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: responsive.hp(50),
                      width: responsive.width,
                      child: Center(
                        child: Text(
                          "Sin movimientos",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: UniCodes.cielbenefics,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
