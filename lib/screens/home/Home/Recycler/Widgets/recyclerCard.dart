import 'package:ambient/domain/models/recycler_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/home/Home/Recycler/Widgets/recyclerDetail.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecyclerCard extends StatelessWidget {
  const RecyclerCard({
    Key? key,
    required this.responsive,
    required this.recyclerList,
  }) : super(key: key);

  final Responsive responsive;
  final RecyclerModel recyclerList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorManager.pushFadeTransition(
            context: context,
            page: RecyclerDetail(
              recyclerModel: recyclerList,
            ));
      },
      child: Hero(
        tag: recyclerList.name,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 254, 248),
                borderRadius: BorderRadius.circular(16)),
            height: 100,
            width: responsive.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/no-image.jpg"),
                        image: NetworkImage(recyclerList.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: responsive.wp(30),
                              child: Text(
                                recyclerList.name,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                )),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Text(
                              " |  ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              width: responsive.wp(20),
                              child: Text(
                                recyclerList.creator,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14)),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: responsive.wp(31),
                              child: Text(
                                recyclerList.description,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.cyclone_outlined,
                              size: 6,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${recyclerList.episodes.length} Eps",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
