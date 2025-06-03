import 'package:flutter/material.dart';

class CleanReservation extends StatefulWidget {
  const CleanReservation({super.key});

  @override
  State<CleanReservation> createState() => _CleanReservationState();
}

class _CleanReservationState extends State<CleanReservation> {
  List<Map<String, dynamic>> reservedTimes = [];

  void addReservation(String time, List<String> days, String mode) {
    bool alreadyExists = reservedTimes.any((r) => r['time'] == time);
    if (!alreadyExists) {
      setState(() {
        reservedTimes.add({'time': time, 'days': days, 'mode': mode});
      });
    }
  }

  void clearReservations() {
    setState(() {
      reservedTimes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: const Text('청소 예약'),
        backgroundColor: const Color(0xFFEFF1F4),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: clearReservations,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                '가영님이 자주 사용하시는 시간대',
                style: TextStyle(
                  color: Color(0xFF606A76),
                  fontSize: 17.45,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 12),
              RecommendedTimes(onTimeSelected: addReservation),
              const SizedBox(height: 24),
              const Text(
                '예약된 시간',
                style: TextStyle(
                  color: Color(0xFF606A76),
                  fontSize: 17.45,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 12),
              ReservationTime(reservedTimes: reservedTimes),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedTimes extends StatelessWidget {
  final void Function(String, List<String>, String) onTimeSelected;

  const RecommendedTimes({super.key, required this.onTimeSelected});

  final List<Map<String, dynamic>> recommended = const [
    {'time': '오전  9 : 00', 'days': ['월', '수', '금'], 'mode': '스마트케어모드'},
    {'time': '오후  2 : 00', 'days': ['화', '목'], 'mode': '습식모드'},
    {'time': '오후  8 : 00', 'days': ['토', '일'], 'mode': '건식모드'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: recommended.map((item) {
        final String time = item['time'] as String;
        final List<String> days = List<String>.from(item['days']);
        final String mode = item['mode'] as String;
        final String dayModeText = '${days.join(', ')} | $mode';

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFE4EAF3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () => onTimeSelected(time, days, mode),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'One UI Sans APP VF',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dayModeText,
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
            ],
          ),
        );
      }).toList(),
    );
  }
}

class ReservationTime extends StatefulWidget {
  final List<Map<String, dynamic>> reservedTimes;
  const ReservationTime({super.key, required this.reservedTimes});

  @override
  State<ReservationTime> createState() => _ReservationTimeState();
}

class _ReservationTimeState extends State<ReservationTime> {
  late List<bool> toggles;

  @override
  void initState() {
    super.initState();
    toggles = List<bool>.filled(widget.reservedTimes.length, true);
  }

  @override
  void didUpdateWidget(covariant ReservationTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reservedTimes.length != widget.reservedTimes.length) {
      List<bool> newToggles = List<bool>.filled(widget.reservedTimes.length, true);
      for (int i = 0; i < oldWidget.reservedTimes.length && i < newToggles.length; i++) {
        newToggles[i] = toggles[i];
      }
      toggles = newToggles;
    }
  }

  void onToggle(int index, bool value) {
    if (index < toggles.length && index >= 0) {
      setState(() {
        toggles[index] = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reservedTimes.isEmpty) {
      return const Text(
        '예약된 시간이 없습니다',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontFamily: 'One UI Sans APP VF',
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 21),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.reservedTimes.length, (i) {
          final item = widget.reservedTimes[i];
          final String time = item['time'] ?? '';
          final String mode = item['mode'] ?? '';
          final String days = item['days']?.join(', ') ?? '';
          final toggleValue = i < toggles.length ? toggles[i] : true;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            time,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontFamily: 'One UI Sans APP VF',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1.44,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$days | $mode',
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
                    CustomToggleSwitch(
                      initialValue: toggleValue,
                      onToggle: (value) => onToggle(i, value),
                    ),
                  ],
                ),
              ),
              if (i != widget.reservedTimes.length - 1) ...[
                const SizedBox(height: 6),
                const Divider(height: 1, color: Color(0xFFD9D9D9)),
                const SizedBox(height: 6),
              ],
            ],
          );
        }),
      ),
    );
  }
}

class CustomToggleSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onToggle;

  const CustomToggleSwitch({super.key, required this.initialValue, required this.onToggle});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
      widget.onToggle(isOn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSwitch,
      child: Container(
        width: 48,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isOn ? const Color(0xFF5E70FF) : const Color(0xFF7F8C9C),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: isOn ? 24 : 3,
              top: 4,
              child: Container(
                width: 21,
                height: 21,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
