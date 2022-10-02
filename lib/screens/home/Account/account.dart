// ignore_for_file: file_names

import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return SizedBox(
      height: responsive.height,
      width: responsive.width,
      child: const Center(child: Text("Account")),
    );
  }
}
