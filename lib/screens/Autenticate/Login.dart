// ignore_for_file: library_private_types_in_public_api
import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/Autenticate/Fortgot.dart';
import 'package:ambient/screens/Autenticate/Register.dart';
import 'package:ambient/screens/home/Home/home.dart';
import 'package:ambient/screens/utils/StreamValidator.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

const _seconds = Duration(seconds: 2);

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    SignInAndUpCubit cubit = context.watch<SignInAndUpCubit>();
    return WillPopScope(
      onWillPop: () async {
        if (cubit.state.runtimeType == SignInAndUpInitial) {
          return true;
        }
        return false;
      },
      child: BlocListener<SignInAndUpCubit, SignInAndUpState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SignInAndUpLoading:
              controller.start();
              break;
            case SignInAndUpLoaded:
              controller.success();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false);
              break;
            case SignInAndUpError:
              controller.error();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: _seconds,
                  content: Text(state.props[0] as String? ?? "")));
              Future.delayed(_seconds, () {
                controller.reset();
              });
              break;
            case SignInAndUpInitial:
              controller.reset();
              break;
            default:
              controller.reset();
              break;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: responsive.height,
              width: responsive.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Image.asset('assets/autenticate/login.png'),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Text(
                          'Iniciar ahora',
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700)),
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        Text(
                          'Por favor ingrese los detalles y continue.',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: UniCodes.gray2)),
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: StreamBuilder(
                              stream: registerBloc.emailStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: registerBloc.changeEmail,
                                  controller: email,
                                  scrollPadding: const EdgeInsets.all(0.0),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    labelText: 'Correo',
                                    errorMaxLines: 2,
                                    errorText: snapshot.error as String?,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    focusColor: UniCodes.gray2,
                                    fillColor: UniCodes.gray2,
                                  ),
                                  validator: (String? value) => value!.isEmpty
                                      ? 'Ingresa tu correo'
                                      : null,
                                );
                              }),
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: StreamBuilder(
                              stream: registerBloc.passwordStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return TextFormField(
                                  obscureText: obstru,
                                  onChanged: registerBloc.changePassword,
                                  controller: password,
                                  scrollPadding: const EdgeInsets.all(0.0),
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obstru = !obstru;
                                          });
                                          if (obstru == false) {
                                            setState(() {
                                              lock = CupertinoIcons.eye;
                                            });
                                          } else {
                                            setState(() {
                                              lock = CupertinoIcons.eye_slash;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          lock,
                                          color: Colors.black,
                                        )),
                                    errorMaxLines: 2,
                                    errorText: snapshot.error as String?,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide:
                                          BorderSide(color: UniCodes.gray2),
                                    ),
                                    focusColor: UniCodes.gray2,
                                    fillColor: UniCodes.gray2,
                                  ),
                                  validator: (String? value) => value!.isEmpty
                                      ? 'Ingresa tu contraseña'
                                      : null,
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                NavigatorManager.pushFadeTransition(
                                    context: context, page: const FortGot());
                              },
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        StreamBuilder(
                            stream: registerBloc.formValidStream,
                            builder: (context, snapshot) {
                              return SizedBox(
                                width: responsive.wp(70),
                                child: RoundedLoadingButton(
                                  color: Theme.of(context).primaryColor,
                                  controller: controller,
                                  onPressed: () async {
                                    if (snapshot.hasData &&
                                        _formKey.currentState!.validate()) {
                                      await cubit.signInMethod(
                                          email: email.text,
                                          password: password.text);
                                    } else {
                                      controller.reset();
                                    }
                                  },
                                  child: Text(
                                    'Iniciar sesion',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (cubit.state.runtimeType == SignInAndUpInitial) {
                              NavigatorManager.pushFadeTransition(
                                  context: context, page: const Register());
                            }
                          },
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'No tienes una cuenta! ',
                                style:
                                    GoogleFonts.poppins(color: UniCodes.gray3)),
                            TextSpan(
                                text: 'Registrate',
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).primaryColor))
                          ])),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
