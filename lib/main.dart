import 'package:ambient/data/autentication_services.dart';
import 'package:ambient/data/home_services.dart';
import 'package:ambient/domain/cubit/autentication/forgot_cubit.dart';
import 'package:ambient/domain/cubit/autentication/sign_in_and_up_cubit.dart';
import 'package:ambient/domain/cubit/general/general_cubit.dart';
import 'package:ambient/domain/cubit/recomendations/recomendations_cubit.dart';
import 'package:ambient/domain/cubit/recycler/recycler_cubit.dart';
import 'package:ambient/domain/cubit/splash/splash_cubit.dart';
import 'package:ambient/domain/services/prefs_services.dart';
import 'package:ambient/screens/Splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ambient/domain/services/push_notification_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationServices.initMessaging();
  await UserPreferences().initPrefs();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    PushNotificationServices.messagesStream.listen((message) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autenticationServices = AutenticationServices();
    final homeServices = HomeServices();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInAndUpCubit(autenticationServices)),
        BlocProvider(create: (_) => ForgotCubit(autenticationServices)),
        BlocProvider(create: (_) => SplashCubit(autenticationServices)),
        BlocProvider(create: (_) => GeneralCubit(autenticationServices)),
        BlocProvider(create: (_) => RecomendationsCubit(homeServices)),
        BlocProvider(create: (_) => RecyclerCubit(homeServices))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rescue the ambient',
        home: Scaffold(
          body: SplashScreen(),
        ),
      ),
    );
  }
}
