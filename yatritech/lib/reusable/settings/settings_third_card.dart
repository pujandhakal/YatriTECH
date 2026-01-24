import 'package:flutter/material.dart';

class SettingsThirdCard extends StatefulWidget {
  const SettingsThirdCard({super.key});

  @override
  State<SettingsThirdCard> createState() => _SettingsThirdCardState();
}

class _SettingsThirdCardState extends State<SettingsThirdCard> {
  bool _isExpanded = false;
  double _crashDetection = 0.9;
  double _theftAlert = 0.85;
  int _sosDelay = 30;
  String _selectedPreset = "Balanced";

  void _incrementDelay() {
    setState(() {
      _sosDelay = (_sosDelay + 5).clamp(5, 120);
    });
  }

  void _decrementDelay() {
    setState(() {
      _sosDelay = (_sosDelay - 5).clamp(5, 120);
    });
  }

  void _applyPreset(String preset) {
    setState(() {
      _selectedPreset = preset;
      switch (preset) {
        case "Relaxed":
          _crashDetection = 0.7;
          _theftAlert = 0.6;
          _sosDelay = 60;
          break;
        case "Balanced":
          _crashDetection = 0.9;
          _theftAlert = 0.85;
          _sosDelay = 30;
          break;
        case "Sensitive":
          _crashDetection = 1.0;
          _theftAlert = 1.0;
          _sosDelay = 15;
          break;
      }
    });
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
            // Header Row
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
                        Icons.notifications_outlined,
                        size: 23.992,
                        color: Color(0xffFFB547),
                      ),
                    ),
                    SizedBox(width: 11.987),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alert Sensitivity",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: Color(0xff343A40),
                          ),
                        ),
                        Text(
                          "Configure detection thresholds",
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

            // Expandable Content
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      children: [
                        SizedBox(height: 25.172),
                        Container(
                          height: 1.18,
                          color: Color(0xFFFFFFFF).withOpacity(0.4),
                        ),
                        SizedBox(height: 25.172),

                        // Crash Detection Slider
                        _buildSlider(
                          icon: Icons.warning_amber_outlined,
                          iconColor: Color(0xffFF6B6B),
                          label: "Crash Detection",
                          value: _crashDetection,
                          percentage: (_crashDetection * 100).toInt(),
                          description: "Higher = triggers on smaller impacts",
                          sliderColor: Color(0xffFF6B6B),
                          onChanged: (value) {
                            setState(() {
                              _crashDetection = value;
                            });
                          },
                        ),
                        SizedBox(height: 23.992),

                        // Theft Alert Slider
                        _buildSlider(
                          icon: Icons.shield_outlined,
                          iconColor: Color(0xffFFB547),
                          label: "Theft Alert",
                          value: _theftAlert,
                          percentage: (_theftAlert * 100).toInt(),
                          description: "Higher = triggers on smaller movements",
                          sliderColor: Color(0xffFFB547),
                          onChanged: (value) {
                            setState(() {
                              _theftAlert = value;
                            });
                          },
                        ),
                        SizedBox(height: 23.992),

                        // SOS Auto-Call Delay
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_in_talk_outlined,
                                  size: 17.999,
                                  color: Color(0xff4DA8DA),
                                ),
                                SizedBox(width: 7.985),
                                Text(
                                  "SOS Auto-Call Delay",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.43,
                                    color: Color(0xff343A40),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.985),
                            Text(
                              "Time before auto-calling emergency services",
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.33,
                                color: Color(0xff6C757D),
                              ),
                            ),
                            SizedBox(height: 11.987),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _decrementDelay,
                                  child: Container(
                                    width: 39.999,
                                    height: 39.999,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffE9ECEF),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff343A40),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 200,
                                  child: Center(
                                    child: Text(
                                      "${_sosDelay}s",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        height: 1.2,
                                        color: Color(0xff343A40),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: _incrementDelay,
                                  child: Container(
                                    width: 39.999,
                                    height: 39.999,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffE9ECEF),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff343A40),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 23.992),

                        // Divider
                        Container(
                          height: 1.18,
                          color: Color(0xFFFFFFFF).withOpacity(0.4),
                        ),
                        SizedBox(height: 17.169),

                        // Quick Presets
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Quick Presets",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              height: 1.43,
                              color: Color(0xff343A40),
                            ),
                          ),
                        ),
                        SizedBox(height: 11.987),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildPresetButton("Relaxed"),
                            _buildPresetButton("Balanced"),
                            _buildPresetButton("Sensitive"),
                          ],
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

  Widget _buildSlider({
    required IconData icon,
    required Color iconColor,
    required String label,
    required double value,
    required int percentage,
    required String description,
    required Color sliderColor,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 17.999, color: iconColor),
                SizedBox(width: 7.985),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.43,
                    color: Color(0xff343A40),
                  ),
                ),
              ],
            ),
            Text(
              "$percentage%",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.56,
                color: Color(0xff343A40),
              ),
            ),
          ],
        ),
        SizedBox(height: 7.985),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12,
              height: 1.33,
              color: Color(0xff6C757D),
            ),
          ),
        ),
        SizedBox(height: 11.987),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: sliderColor,
            inactiveTrackColor: Color(0xffE9ECEF),
            thumbColor: sliderColor,
            trackHeight: 7.985,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(value: value, min: 0.0, max: 1.0, onChanged: onChanged),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Low",
              style: TextStyle(
                fontSize: 12,
                height: 1.33,
                color: Color(0xff6C757D),
              ),
            ),
            Text(
              "High",
              style: TextStyle(
                fontSize: 12,
                height: 1.33,
                color: Color(0xff6C757D),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPresetButton(String preset) {
    final isSelected = _selectedPreset == preset;
    return GestureDetector(
      onTap: () => _applyPreset(preset),
      child: Container(
        width: 100,
        height: 34.338,
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xff4DA8DA).withOpacity(0.1)
              : Color(0xffE9ECEF).withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Color(0xff4DA8DA).withOpacity(0.3)
                : Color(0xFFFFFFFF).withOpacity(0.4),
            width: 1.18,
          ),
        ),
        child: Center(
          child: Text(
            preset,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.33,
              color: isSelected ? Color(0xff4DA8DA) : Color(0xff343A40),
            ),
          ),
        ),
      ),
    );
  }
}
