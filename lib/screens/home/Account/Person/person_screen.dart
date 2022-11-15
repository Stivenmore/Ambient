import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/Splash/splash.dart';
import 'package:ambient/screens/home/Account/Person/editar_person.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatelessWidget {
  final UserModel userModel;
  const UserScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: SizedBox(
        height: responsive.height,
        width: responsive.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            NavigatorManager.ofPoPFadeTrasition(
                                context: context);
                          },
                          icon: const Icon(Icons.arrow_back_ios))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 130,
                        width: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(76),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/no-image.jpg",
                            image: userModel.img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          width: 130,
                          child: InkWell(
                            onTap: () {
                              NavigatorManager.pushFadeTransition(
                                  context: context,
                                  page: EditPerson(user: userModel));
                            },
                            child: CircleAvatar(
                              maxRadius: 22,
                              backgroundColor: UniCodes.whiteperformance,
                              child: Center(
                                child: CircleAvatar(
                                  maxRadius: 18,
                                  backgroundColor: UniCodes.blueperformance,
                                  child: Center(
                                    child: Icon(
                                      Icons.edit,
                                      color: UniCodes.whiteperformance,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Text(
                      userModel.nombre,
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      userModel.phone,
                      style: GoogleFonts.montserrat(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                const OptionsProfile(
                  icon: Icon(
                    Icons.phone_in_talk_outlined,
                  ),
                  label: "Contactanos",
                ),
                const SizedBox(
                  height: 10,
                ),
                const OptionsProfile(
                  icon: Icon(
                    Icons.security,
                  ),
                  label: "Politicas de privacidas",
                ),
                const SizedBox(
                  height: 10,
                ),
                const OptionsProfile(
                  icon: Icon(
                    Icons.picture_as_pdf_outlined,
                  ),
                  label: "Terminos y condiciones",
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.read<SignInAndUpCubit>().signOutMethod();
                    NavigatorManager.inTopushFadeTransition(
                        context: context, page: const SplashScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Cerrar sesion",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[700], fontSize: 20),
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
  }
}

class OptionsProfile extends StatelessWidget {
  const OptionsProfile({Key? key, required this.icon, required this.label})
      : super(key: key);

  final String label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Text(label, style: GoogleFonts.montserrat(fontSize: 20))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: UniCodes.gray3,
        )
      ],
    );
  }
}
