import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
          _buildSidebarItem(Icons.dashboard, "Dashboard", isSelected: true),
          _buildSidebarItem(Icons.folder_shared, "My Policies"),
          _buildSidebarItem(Icons.receipt_long, "Claims"),
          _buildSidebarItem(Icons.payments, "Payments"),
          _buildSidebarItem(Icons.support_agent, "Support"),
          Spacer(),
          _buildSidebarItem(Icons.settings, "Settings"),
          _buildSidebarItem(Icons.logout, "Logout"),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    IconData icon,
    String title, {
    bool isSelected = false,
  }) {
    return Material(
      color: isSelected ? Colors.blue.shade800 : Colors.transparent,
      child: InkWell(
        onTap: () {},
        hoverColor: Colors.blue.shade700,
        child: ListTile(
          leading: Icon(icon, color: Colors.white70),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back, Pujan!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Here is an overview of your insurance portfolio.",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),

        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(children: []);
        }
        return Row(children: []);
      },
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          )
        ],),
      ),
    );
  }
}
