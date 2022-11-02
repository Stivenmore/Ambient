import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/Autenticate/Login.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SizedBox(
        height: responsive.height,
        width: responsive.width,
        child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: 80.0),
            duration: const Duration(seconds: 2),
            builder: (context, double angulo, __) {
              return Transform.scale(
                scaleX: angulo*2.1,
                scaleY: angulo*2.1,
                child: Transform.rotate(
                  angle: angulo/3.5,
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              );
            }, onEnd: (){
              NavigatorManager.pushFadeTransition(context: context, page: const Login());
            },),
      ),
    );
  }
}
