import 'package:ambient/data/autentication_services.dart';
import 'package:ambient/domain/cubit/cubit/forgot_cubit.dart';
import 'package:ambient/domain/cubit/cubit/sign_in_and_up_cubit.dart';
import 'package:ambient/screens/Autenticate/Login.dart';
import 'package:ambient/screens/Splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ambient/domain/services/push_notification_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationServices.initMessaging();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInAndUpCubit(AutenticationServices())),
        BlocProvider(create: (_) => ForgotCubit(AutenticationServices()))
      ],
      child:  const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ambient',
        home: Scaffold(
          body: Splash(),
        ),
      ),
    );
  }
}
