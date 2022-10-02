import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';

class BeneficScreen extends StatelessWidget {
  const BeneficScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: SizedBox(
        height: responsive.height,
        width: responsive.width,
        child: const Center(child: Text("Benefic")),
      ),
    );
  }
}
