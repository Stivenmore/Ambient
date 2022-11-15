import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/cubit/splash/splash_cubit.dart';
import 'package:ambient/domain/models/user_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditPerson extends StatefulWidget {
  final UserModel user;
  const EditPerson({super.key, required this.user});

  @override
  State<EditPerson> createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  late UserModel local;

  @override
  void initState() {
    local = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Builder(builder: (context) {
      final state = context.select<GeneralCubit, GeneralStateUserPhoto>(
          (value) => value.state.generalStateUserPhoto);
      final state2 = context.select<GeneralCubit, GeneralStateUserUpdate>(
          (value) => value.state.update);
      switch (state2) {
        case GeneralStateUserUpdate.loading:
          controller.start();
          break;
        case GeneralStateUserUpdate.success:
          controller.success();
          Future.delayed(const Duration(seconds: 2), () {
            controller.reset();
            context.read<SplashCubit>().getUser();
            context.read<GeneralCubit>().resetState();
            NavigatorManager.ofPoPFadeTrasition(context: context);
            NavigatorManager.ofPoPFadeTrasition(context: context);
          });
          break;
        case GeneralStateUserUpdate.error:
          controller.error();
          break;
        default:
      }
      return Scaffold(
        body: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<GeneralCubit>().resetState();
                                  NavigatorManager.ofPoPFadeTrasition(
                                      context: context);
                                },
                                icon: const Icon(Icons.arrow_back_ios))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
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
                                child: state == GeneralStateUserPhoto.none
                                    ? FadeInImage.assetNetwork(
                                        placeholder: "assets/no-image.jpg",
                                        image: local.img,
                                        fit: BoxFit.cover,
                                      )
                                    : state == GeneralStateUserPhoto.loading
                                        ? CircularProgressIndicator(
                                            backgroundColor: UniCodes.green,
                                            color: Colors.white,
                                          )
                                        : state == GeneralStateUserPhoto.success
                                            ? Container(
                                                decoration: BoxDecoration(
                                                    color: UniCodes.green),
                                                child: Center(
                                                  child: Text(
                                                    "Imagen Cargada",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: UniCodes.green),
                                                child: Center(
                                                  child: Text(
                                                    "Error",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                              ),
                              ),
                            ),
                            Positioned(
                                bottom: 5,
                                width: 130,
                                child: InkWell(
                                  onTap: () {
                                    context.read<GeneralCubit>().getImageUser();
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 22,
                                    backgroundColor: UniCodes.whiteperformance,
                                    child: Center(
                                      child: CircleAvatar(
                                        maxRadius: 22,
                                        backgroundColor:
                                            UniCodes.blueperformance,
                                        child: Center(
                                          child: Icon(
                                            Icons.camera,
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
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: name,
                        scrollPadding: const EdgeInsets.all(0.0),
                        onChanged: (value) {
                          setState(() {
                            local.nombre = value;
                          });
                        },
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText: local.nombre,
                          errorMaxLines: 2,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          focusColor: UniCodes.gray2,
                          fillColor: UniCodes.gray2,
                        ),
                        validator: (String? value) =>
                            value!.isEmpty ? 'Ingresa tu nombre' : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: address,
                        scrollPadding: const EdgeInsets.all(0.0),
                        onChanged: (value) {
                          setState(() {
                            local.address = value;
                          });
                        },
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText: local.address.isEmpty
                              ? "Direccion..."
                              : local.address,
                          errorMaxLines: 2,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          focusColor: UniCodes.gray2,
                          fillColor: UniCodes.gray2,
                        ),
                        validator: (String? value) =>
                            value!.isEmpty ? 'Ingresa tu direccion' : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phone,
                        scrollPadding: const EdgeInsets.all(0.0),
                        onChanged: (value) {
                          setState(() {
                            local.phone = value;
                          });
                        },
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText:
                              local.phone.isEmpty ? "Telefono..." : local.phone,
                          errorMaxLines: 2,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: UniCodes.gray2),
                          ),
                          focusColor: UniCodes.gray2,
                          fillColor: UniCodes.gray2,
                        ),
                        validator: (String? value) =>
                            value!.isEmpty ? 'Ingresa tu numero' : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Activar notificacion de recoleccion',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          Switch(
                              value: local.activate ?? false,
                              onChanged: (v) {
                                setState(() {
                                  local.activate = v;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    child: RoundedLoadingButton(
                      color: UniCodes.green,
                      borderRadius: 10,
                      controller: controller,
                      onPressed: () async {
                        if (local.activate == true) {
                          if (phone.text.isNotEmpty ||
                              address.text.isNotEmpty) {
                            context.read<GeneralCubit>().updateUser(local);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Debe agregar un numero o una direccion',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ));
                            controller.reset();
                          }
                        }
                      },
                      child: Text(
                        'Actualizar',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
