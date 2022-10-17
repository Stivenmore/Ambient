import 'dart:math';

import 'package:ambient/domain/models/recomendations_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/home/Home/Recomendations/Widgets/playersPodcast.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecomendationCard extends StatefulWidget {
  final RecomendationsModel list;
  const RecomendationCard({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<RecomendationCard> createState() => _RecomendationCardState();
}

class _RecomendationCardState extends State<RecomendationCard> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    audioPlayer = AudioPlayer(playerId: widget.list.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorManager.pushFadeTransition(
            context: context,
            page: PlayerWidget(
              recomendationsModel: widget.list,
              audioPlayer: audioPlayer,
              idNotification: Random().nextInt(10),
            ));
      },
      child: Hero(
        tag: widget.list.name,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 240,
                width: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/no-image.jpg"),
                    image: NetworkImage(widget.list.img),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.bottomLeft,
                height: 70,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.list.name,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      maxLines: 2,
                    ),
                    Text(
                      widget.list.type,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.grey[350],
                              fontWeight: FontWeight.w700,
                              fontSize: 12)),
                    )
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
