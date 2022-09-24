// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:ambient/screens/utils/StreamValidator.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FortGot extends StatefulWidget {
  const FortGot({Key? key}) : super(key: key);

  @override
  _FortGotState createState() => _FortGotState();
}

class _FortGotState extends State<FortGot> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  IconData lock = CupertinoIcons.eye_slash;
  final registerBloc = RegisterBloc();
  bool obstru = true;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SizedBox(
        height: responsive.height,
        width: responsive.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: responsive.hp(20),
                  ),
                  Image.asset('assets/autenticate/login.png'),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Text(
                    'Restablecer contraseña',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recibiras un correo electronico para restablecer tu contraseña.',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: UniCode.gray2)),
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(4),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    scrollPadding: EdgeInsets.all(0.0),
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: UniCode.gray2),
                      ),
                      focusColor: UniCode.gray2,
                      fillColor: UniCode.gray2,
                    ),
                    validator: (String? value) =>
                        value!.isEmpty ? 'Ingresa tu correo' : null,
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  SizedBox(
                    width: responsive.wp(70),
                    child: RoundedLoadingButton(
                      color: Theme.of(context).primaryColor,
                      controller: controller,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                        } else {}
                      },
                      child: Text(
                        'Enviar Correo',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text('Volver',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle())))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
