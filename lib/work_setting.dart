import 'package:flutter/material.dart';

class CleanSpace extends StatelessWidget {
  final String title;
  final IconData icon;

  const CleanSpace({
    super.key,
    required this.title,
    required this.icon,
  });

  Widget _buildLegendItem(Color color, String label) {
    return Expanded(
      child: Row(
        children: [
          Container(width: 34, height: 12, color: color),
          const SizedBox(width: 12),
          Opacity(
            opacity: 0.98,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF606A76),
                fontSize: 12,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.08,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Container(
              width: 334,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            icon,
                            color: const Color(0xFF4A58BB),
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'One UI Sans APP VF',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1.44,
                            ),
                          ),
                        ],
                      ),
                      const Opacity(
                        opacity: 0.98,
                        child: Text(
                          '수정하기',
                          style: TextStyle(
                            color: Color(0xFF606A76),
                            fontSize: 16,
                            fontFamily: 'One UI Sans APP VF',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -1.44,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 191,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildLegendItem(const Color(0xFFFF705E), '기름때 집중 케어'),
                      _buildLegendItem(const Color(0xFF5E70FF), '물때 집중 케어'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildLegendItem(const Color(0xFF21FF15), '부스러기 집중 케어'),
                      _buildLegendItem(const Color(0xFF9E9E9E), '청소 금지 구역'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class CleanMode extends StatefulWidget {
  const CleanMode({super.key});

  @override
  State<CleanMode> createState() => _CleanModeState();
}

class _CleanModeState extends State<CleanMode> {
  String _selectedMode = '스마트 케어 모드';
  double _progress = 0.3;

  final Map<String, IconData> modeIcons = {
    '스마트 케어 모드': Icons.psychology,
    '표준 모드': Icons.cleaning_services,
    '건식 모드': Icons.air,
    '습식 모드': Icons.water_drop,
  };

  Widget _buildModeButton(String label) {
    final isSelected = _selectedMode == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6ECFF3) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF646B7B),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: -0.96,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double barWidth = 392;
    const double imageSize = 30;

    return SizedBox(
      width: barWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 모드 선택 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: modeIcons.keys.map(_buildModeButton).toList(),
            ),
          ),
          const SizedBox(height: 12),

          // 모드 설명 카드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(modeIcons[_selectedMode], size: 24, color: const Color(0xFF6ECFF3)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedMode,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.44,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(
                        width: 241,
                        child: Text(
                          '영역에 맞춰 맞춤 청소를 할게요.',
                          style: TextStyle(
                            color: Color(0xFF575A9F),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -1.28,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 예상 시간 및 진행 바
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Opacity(
                  opacity: 0.98,
                  child: Text(
                    '예상 총 소요시간 : 5분',
                    style: TextStyle(
                      color: Color(0xFF606A76),
                      fontSize: 16,
                      letterSpacing: -1.44,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 이미지 줄
                SizedBox(
                  width: barWidth,
                  height: imageSize,
                  child: Stack(
                    children: [
                      Positioned(
                        left : ((_progress-0.05) * barWidth) - (imageSize/2 ),
                        child: Image.asset(
                          'assets/cleaner.png',
                          width: imageSize,
                          height: imageSize,
                        ),
                      ),
                    ],
                  ),
                ),
                

                // 진행 바
                Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6ECFF3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(_progress * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 시작 버튼 및 원형 아이콘
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _progress += 0.1;
                      if (_progress > 1.0) _progress = 0.0;
                    });
                  },
                  child: Container(
                    width: 296,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF495F7D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '청소 ', style: TextStyle(letterSpacing: -0.54)),
                          TextSpan(text: '시', style: TextStyle(letterSpacing: -0.90)),
                          TextSpan(text: '작', style: TextStyle(letterSpacing: -0.54)),
                        ],
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4), // 안쪽 여백 조절
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // 둥근 모서리(원형 유지)
                      child: Image.asset('assets/home.png'),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}



class SmartCare extends StatelessWidget {
  const SmartCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD8EBF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SmartCareItem(
              icon: Icons.oil_barrel,
              text: '기름때 집중 케어',
            ),
            Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.water,
              text: '물때 집중 케어',
            ),
            Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.brush,
              text: '부스러기 집중 케어',
            ),
          ],
        ),
      ),
    );
  }
}


class SmartCareItem extends StatefulWidget {
  final IconData icon;
  final String text;

  const SmartCareItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  State<SmartCareItem> createState() => _SmartCareItemState();
}

class _SmartCareItemState extends State<SmartCareItem> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Icon(widget.icon, color: const Color(0xFF495F7D)),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w500,
                letterSpacing: -1.44,
              ),
            ),
          ),
          Switch(
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
            },
            activeColor: const Color(0xFFD8EBF1),
            activeTrackColor: const Color(0xFF5E70FF),
            inactiveTrackColor: const Color(0xFFE0E0E0),
          ),
        ],
      ),
    );
  }
}


class AftercleanCare extends StatelessWidget {
  const AftercleanCare({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD8EBF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SmartCareItem(
              icon: Icons.bubble_chart,
              text: '잔수 제거',
            ),
            Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.grain,
              text: '먼지통 비우기',
            ),
            Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.soap,
              text: '물걸레 세척',
            ),
          ],
        ),
      ),
    );
  }
}


class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddServiceItem(
              icon: Icons.schedule,
              title: '청소 예약',
              subtitle: '청소 시간을 예약해요.',
            ),
            Divider(height: 1, color: Color(0xFFD9D9D9)),
            AddServiceItem(
              icon: Icons.settings,
              title: '세부 기능 설정',
              subtitle: '청소의 세부 기능을 설정합니다.',
            ),
          ],
        ),
      ),
    );
  }
}

class AddServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const AddServiceItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF495F7D), size: 24),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w500,
                    letterSpacing: -1.44,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF575A9F),
                    fontSize: 16,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.28,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFFB0B0B0)),
        ],
      ),
    );
  }
}
