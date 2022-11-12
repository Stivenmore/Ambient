import 'package:ambient/domain/cubit/benefics/benefics_cubit.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculateSuccess extends StatefulWidget {
  const CalculateSuccess({super.key});

  @override
  State<CalculateSuccess> createState() => _CalculateSuccessState();
}

class _CalculateSuccessState extends State<CalculateSuccess> {
  TextEditingController controller = TextEditingController();
  final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: UniCodes.whiteperformance));
  final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(16), color: UniCodes.gray1);
  double value = 0;
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BeneficsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text("Calculadora de puntos",
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(fontSize: 18, color: Colors.black))),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: boxDecoration,
                height: 50,
                width: 150,
                child: TextFormField(
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      setState(() {
                        value = double.parse(v) *
                            cubit.state.configmodel[0].pricepoint;
                      });
                    } else {
                      setState(() {
                        value = 0.0;
                      });
                    }
                  },
                  decoration: InputDecoration(
                      label: Text(
                        "Escriba...",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 18, color: UniCodes.blueperformance)),
                      ),
                      border: borderStyle,
                      errorBorder: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle),
                ),
              ),
              Text(
                "x${cubit.state.configmodel.isNotEmpty ? cubit.state.configmodel[0].pricepoint.toString() : '...'}",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 18, color: UniCodes.blueperformance)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 50,
                width: 130,
                decoration: boxDecoration,
                child: Text(
                  "  =  $value",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 18, color: UniCodes.blueperformance)),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
