import 'package:flutter/material.dart';

class JourneyFirstCard extends StatefulWidget {
  final VoidCallback? onHeatmapToggle;
  final bool showHeatmap;
  const JourneyFirstCard({
    super.key,
    this.onHeatmapToggle,
    this.showHeatmap = false,
  });

  @override
  State<JourneyFirstCard> createState() => _JourneyFirstCardState();
}

class _JourneyFirstCardState extends State<JourneyFirstCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 32,
            spreadRadius: -8,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            spreadRadius: -4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'This Week',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF6C757D),
                ),
              ),
              GestureDetector(
                onTap: widget.onHeatmapToggle,
                child: Container(
                  height: 31.977,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: widget.showHeatmap
                        ? const Color(0xff4DA8DA)
                        : const Color(0xFFE9ECEF),
                    borderRadius: BorderRadius.circular(39602500),
                  ),
                  child: Center(
                    child: Text(
                      widget.showHeatmap ? 'Hide Heatmap' : 'Show Heatmap',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.43,
                        color: widget.showHeatmap
                            ? Colors.white
                            : const Color(0xFF6C757D),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stats Row
          AnimatedBuilder(
            animation: _animation ?? AlwaysStoppedAnimation(1.0),
            builder: (context, child) {
              final animationValue = _animation?.value ?? 1.0;
              final distance = (248 * animationValue).toInt();
              final totalMinutes = (402 * animationValue).toInt();
              final hours = totalMinutes ~/ 60;
              final minutes = totalMinutes % 60;
              final avgSpeed = (32 * animationValue).toInt();

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem(
                      icon: Icons.trending_up,
                      value: '$distance km',
                      label: 'Distance',
                      colorName: Color(0xff4DA8DA),
                    ),
                    _buildStatItem(
                      icon: Icons.access_time,
                      value: '${hours}h ${minutes}m',
                      label: 'Drive Time',
                      colorName: Color(0xff6ACFCF),
                    ),
                    _buildStatItem(
                      icon: Icons.speed,
                      value: '$avgSpeed km/h',
                      label: 'Avg Speed',
                      colorName: Color(0xffFFB547),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color colorName,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 19.99, color: colorName),
        const SizedBox(height: 7.985),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            height: 1.5,
            color: Color(0xFF343A40),
          ),
        ),
        const SizedBox(height: 7.985),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            height: 1.33,
            color: Color(0xFF6C757D),
          ),
        ),
      ],
    );
  }
}
