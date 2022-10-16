import 'package:ambient/domain/models/recomendations_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/domain/services/push_notification_services.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerWidget extends StatefulWidget {
  final int idNotification;
  final AudioPlayer audioPlayer;
  final bool? isUser;
  final RecomendationsModel recomendationsModel;

  const PlayerWidget({
    super.key,
    required this.audioPlayer,
    required this.idNotification,
    required this.recomendationsModel,
    this.isUser,
  });

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget>
    with WidgetsBindingObserver {
  bool ignored = false;
  PlayerState playerState = PlayerState.completed;

  _PlayerWidgetState();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (playerState == PlayerState.playing ||
        PushNotificationServices.stateLocalNotifications()) {
      switch (state) {
        case AppLifecycleState.resumed:
          break;
        case AppLifecycleState.detached:
          PushNotificationServices.sendLocalNotification(
              idNotification: widget.idNotification.toString(),
              nameNotification: widget.recomendationsModel.name,
              dateId: widget.idNotification,
              endTime: DateTime.now().millisecondsSinceEpoch + 1000);
          break;
        case AppLifecycleState.inactive:
          PushNotificationServices.sendLocalNotification(
              idNotification: widget.idNotification.toString(),
              nameNotification: widget.recomendationsModel.name,
              dateId: widget.idNotification,
              endTime: DateTime.now().millisecondsSinceEpoch + 1000);
          break;
        case AppLifecycleState.paused:
          PushNotificationServices.sendLocalNotification(
              idNotification: widget.idNotification.toString(),
              nameNotification: widget.recomendationsModel.name,
              dateId: widget.idNotification,
              endTime: DateTime.now().millisecondsSinceEpoch + 1000);
          break;
        default:
      }
    } else {}
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          playerState = PlayerState.stopped;
        });
        widget.audioPlayer.dispose();
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: NetworkImage(widget.recomendationsModel.img),
                        fit: BoxFit.fitHeight)),
                height: responsive.height,
                width: responsive.width,
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 110, 109, 109),
                      Color.fromARGB(255, 110, 109, 109),
                      Color.fromARGB(255, 110, 109, 109),
                      Color.fromARGB(255, 69, 69, 69),
                      Color.fromARGB(255, 0, 0, 0)
                    ],
                    stops: [0.1, 0.3, 0.5, 0.6, 1.0],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  )),
                  height: responsive.height,
                  width: responsive.width,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                playerState = PlayerState.stopped;
                              });
                              widget.audioPlayer.dispose();
                              NavigatorManager.ofPoPFadeTrasition(
                                  context: context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )),
                        Column(
                          children: [
                            Text(
                              "Escuchando desde Podcast",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 222, 220, 220),
                                      fontWeight: FontWeight.w700)),
                            ),
                            Text(
                              widget.recomendationsModel.name,
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage("assets/no-image.jpg"),
                              image:
                                  NetworkImage(widget.recomendationsModel.img),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.recomendationsModel.name,
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.recomendationsModel.upload,
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 222, 220, 220),
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    Container(
                      height: 58,
                      width: 60,
                      decoration: BoxDecoration(
                          color: const Color(0xff7A7B8C),
                          borderRadius: BorderRadius.circular(48)),
                      child: Center(
                        child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () async {
                              if (playerState == PlayerState.playing) {
                                widget.audioPlayer.pause();
                                setState(() {
                                  playerState = PlayerState.paused;
                                });
                              } else if (playerState == PlayerState.paused) {
                                await widget.audioPlayer.resume();
                                setState(() {
                                  playerState = PlayerState.playing;
                                });
                              } else {
                                await widget.audioPlayer.play(
                                  UrlSource(widget.recomendationsModel.podcast),
                                );
                                setState(() {
                                  playerState = PlayerState.playing;
                                });
                              }
                            },
                            iconSize: 26.0,
                            icon: playerState == PlayerState.playing
                                ? const Icon(
                                    Icons.pause,
                                    size: 34,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    size: 34,
                                  ),
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
