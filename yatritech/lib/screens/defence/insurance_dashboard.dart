import 'package:flutter/material.dart';

class InsuranceDashboard extends StatelessWidget {
  const InsuranceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //Determin if it's web or mobile screen(wide or narrow screen )
    final isDesktop = MediaQuery.of(context).size.width >= 800;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: isDesktop
          ? null
          : AppBar(
              title: Text("Insurance Dashboard"),
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.white,
            ),
      drawer: isDesktop ? null : _buildSidebar(context),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blue.shade900,
      child: Column(
        children: [
          SizedBox(height: 32),
          Icon(Icons.shield, color: Colors.white, size: 64),
          SizedBox(height: 16),
          Text(
            "SecureLife",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    IconData icon,
    String title, {
    bool isSelected = false,
  }) {
    return Material();
  }
}
