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
          return Column(
            children: [
              _buildStatCard(
                "Active Policies",
                '3',
                Icons.verified_user,
                Colors.green,
              ),
              SizedBox(height: 16),
              _buildStatCard(
                "Pending Claims",
                '1',
                Icons.access_time,
                Colors.orange,
              ),
              SizedBox(height: 16),
              _buildStatCard(
                "Total Coverage",
                '\$500k',
                Icons.attach_money,
                Colors.blue,
              ),
            ],
          );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(icon, color: color, size: 28),
              ],
            ),
            SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentClaims(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Claims",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: 24,
                  columns: [
                    DataColumn(label: Text("Claim ID")),
                    DataColumn(label: Text("Policy")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: [
                    _buildClaimRow(
                      'CLM-2026-891',
                      'Auto Insurance',
                      'Oct 12, 2026',
                      '\$1,250',
                      'Approved',
                      Colors.green,
                    ),
                    _buildClaimRow(
                      'CLM-2026-642',
                      'Health Insurance',
                      'Nov 05, 2026',
                      '\$340',
                      'Pending',
                      Colors.orange,
                    ),
                    _buildClaimRow(
                      'CLM-2025-112',
                      'Home Insurance',
                      'Dec 18, 2025',
                      '\$4,500',
                      'Paid',
                      Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildClaimRow(
    String id,
    String policy,
    String date,
    String amount,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(id, style: TextStyle(fontWeight: FontWeight.w500))),
        DataCell(Text(policy)),
        DataCell(Text(date)),
        DataCell(Text(amount)),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildActionTile(
              'File a New Claim',
              Icons.add_circle_outline,
              Colors.blue,
            ),
            Divider(),
            _buildActionTile('Make a Payment', Icons.payment, Colors.green),
            Divider(),
            _buildActionTile('Download ID Card', Icons.badge, Colors.purple),
            Divider(),
            _buildActionTile("Contact Agent", Icons.headset_mic, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, Color color) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.chevron_right),
      hoverColor: Colors.grey.shade100,
      onTap: () {},
    );
  }
}
