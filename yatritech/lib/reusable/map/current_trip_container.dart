import 'package:flutter/material.dart';

class CurrentTripContainer extends StatefulWidget {
  const CurrentTripContainer({super.key});

  @override
  State<CurrentTripContainer> createState() => _CurrentTripContainerState();
}

class _CurrentTripContainerState extends State<CurrentTripContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(220, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(60, 0, 0, 0),
            offset: Offset(0, 10),
            blurRadius: 25,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: title + tracking badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Trip',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF6C757D),
                      height: 16 / 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Active Journey',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF343A40),
                      height: 28 / 18,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF51CF66).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color(0xFF51CF66).withValues(alpha: 0.3),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Tracking',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2F9E44),
                    height: 16 / 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Trip metrics row
          Row(
            children: [
              Expanded(
                child: _TripMetric(
                  icon: Icons.access_time_rounded,
                  iconColor: Color(0xff4DA8DA),
                  value: '21:32',
                  label: 'Time',
                ),
              ),
              Expanded(
                child: _TripMetric(
                  icon: Icons.route_rounded,
                  iconColor: Color(0xff6ACFCF),
                  value: '12.8 km',
                  label: 'Distance',
                ),
              ),
              Expanded(
                child: _TripMetric(
                  icon: Icons.speed_rounded,
                  iconColor: Color(0xffFFB547),
                  value: '33 km/h',
                  label: 'Avg Speed',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TripMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _TripMetric({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF343A40),
            height: 20 / 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: const Color(0xFF6C757D),
            height: 15 / 10,
          ),
        ),
      ],
    );
  }
}
