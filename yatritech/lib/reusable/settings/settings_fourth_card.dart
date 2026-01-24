import 'package:flutter/material.dart';

class SettingsFourthCard extends StatefulWidget {
  const SettingsFourthCard({super.key});

  @override
  State<SettingsFourthCard> createState() => _SettingsFourthCardState();
}

class _SettingsFourthCardState extends State<SettingsFourthCard> {
  bool _isExpanded = false;

  Widget _buildContactRow(
    String number,
    String name,
    String type,
    String phone,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE9ECEF).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFFFFFFF).withOpacity(0.4),
          width: 1.18,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 17.169, vertical: 17.169),
      margin: EdgeInsets.only(bottom: 11.987),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 39.999,
                height: 39.999,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff4DA8DA), Color(0xff73C2FB)],
                  ),
                  borderRadius: BorderRadius.circular(39602500),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 11.987),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff343A40),
                      height: 1.43,
                    ),
                  ),
                  Text(
                    "$type • $phone",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff6C757D),
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 31.959,
            height: 31.959,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF).withOpacity(0.7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.phone, size: 15.989, color: Color(0xff4DA8DA)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF).withOpacity(0.7),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Color(0xFFFFFFFF).withOpacity(0.4),
            width: 1.18,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 32,
              offset: Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 23.992, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 47.966,
                      height: 47.966,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFFFFF).withOpacity(0.6),
                            Color(0xFFFFFFFF).withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.contacts_outlined,
                        size: 23.992,
                        color: Color(0xff4DA8DA),
                      ),
                    ),
                    SizedBox(width: 11.987),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Emergency Contacts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: Color(0xff343A40),
                          ),
                        ),
                        Text(
                          "3 contacts configured",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.43,
                            color: Color(0xff6C757D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.25 : 0,
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.chevron_right,
                    size: 19.99,
                    color: Color(0xff6C757D),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      children: [
                        SizedBox(height: 24),
                        _buildContactRow(
                          "1",
                          "Sagar Bist",
                          "Primary",
                          "9812776353",
                        ),
                        _buildContactRow(
                          "2",
                          "Pabitra Kumar Chalise",
                          "Secondary",
                          "9745619490",
                        ),
                        _buildContactRow(
                          "3",
                          "Emergency Services",
                          "Medical",
                          "102",
                        ),
                        Container(
                          height: 46.325,
                          decoration: BoxDecoration(
                            color: Color(0xff4DA8DA).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xff4DA8DA).withOpacity(0.3),
                              width: 1.18,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "+ Add Emergency Contact",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4DA8DA),
                                height: 1.43,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
