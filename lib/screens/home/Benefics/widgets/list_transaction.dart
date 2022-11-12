import 'package:ambient/domain/models/user_model.dart';
import 'package:ambient/screens/utils/responsive.dart';
import 'package:ambient/screens/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTransation extends StatelessWidget {
  final List<Transaction> transaction;
  const ListTransation({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            Container(
              height: 60,
              width: responsive.width,
              decoration: BoxDecoration(color: UniCodes.gray1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 5,
                        decoration: BoxDecoration(
                          color: transaction[index].color,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fecha",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: UniCodes.blueblack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              transaction[index].time,
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: UniCodes.blueblack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "${transaction[index].point}P".toString(),
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: UniCodes.cielbenefics,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        transaction[index].icon
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider()
          ],
        );
      }, childCount: transaction.length),
    );
  }
}
