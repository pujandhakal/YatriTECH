import 'package:flutter/material.dart';

class InsuranceDashboard extends StatelessWidget {
  const InsuranceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //Determin if it's web or mobile screen(wide or narrow screen )
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
    );
  }
}
