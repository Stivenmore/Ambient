import 'package:ambient/domain/models/recycler_model.dart';
import 'package:ambient/domain/services/navitation_manage.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecyclerDetail extends StatefulWidget {
  final RecyclerModel recyclerModel;
  const RecyclerDetail({super.key, required this.recyclerModel});

  @override
  State<RecyclerDetail> createState() => _RecyclerDetailState();
}

class _RecyclerDetailState extends State<RecyclerDetail> {
  int curretPage = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: curretPage);
    super.initState();
  }

  void streamCurrentPage(int onCurrentPage) {
    setState(() {
      curretPage = onCurrentPage;
    });
    if (kDebugMode) {
      print("PageCurrent: $onCurrentPage");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<EpisodeModel> list = widget.recyclerModel.episodes;
    Responsive responsive = Responsive(context);
    return WillPopScope(
      onWillPop: () async {
        if (curretPage < list.length && curretPage != 0) {
          controller.previousPage(
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceIn);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SizedBox(
          height: responsive.height,
          width: responsive.width,
          child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              itemCount: list.length,
              onPageChanged: (value) => streamCurrentPage(value),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                  child: SizedBox(
                    height: responsive.height,
                    width: responsive.width,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    if (curretPage < list.length &&
                                        curretPage != 0) {
                                      controller.previousPage(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.bounceIn);
                                    } else if (curretPage == 0) {
                                      NavigatorManager.ofPoPFadeTrasition(
                                          context: context);
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              SizedBox(
                                width: responsive.wp(65),
                                child: Text(
                                  list[index].name,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16)),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (curretPage < list.length - 1) {
                                      controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 100),
                                          curve: Curves.bounceIn);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: curretPage < list.length - 1
                                        ? Colors.black
                                        : Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            list[index].problem.isNotEmpty ? "Problema" : '',
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(
                            height: list[index].description.isNotEmpty ? 20 : 0,
                          ),
                          Text(
                            list[index].description,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: list[index].problem.isNotEmpty ? 20 : 0,
                          ),
                          Text(
                            list[index].problem,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          ),
                          SizedBox(
                            height: list[index].options.isNotEmpty ? 30 : 0,
                          ),
                          Text(
                            list[index].options.isNotEmpty
                                ? "Como podemos ayudar en este problema?"
                                : "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(
                              height: 130.0 * list[index].options.length,
                              width: responsive.width,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: list[index].options.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "*  ${list[index].options[i]}",
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    );
                                  }))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
