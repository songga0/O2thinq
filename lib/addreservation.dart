import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReservation extends StatelessWidget {
  const AddReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: const Text('청소 예약'),
        backgroundColor: const Color(0xFFEFF1F4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                '시작시간 예약',
                style: TextStyle(
                  color: Color(0xFF606A76),
                  fontSize: 17.45,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(height: 12),
              const StartTime(),
              const SizedBox(height: 16),
              const Text(
                '세부 설정',
                style: TextStyle(
                  color: Color(0xFF606A76),
                  fontSize: 17.45,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.35,
                ),
              ),const SizedBox(height: 12,),
              const ReservationDetail(),
              const SizedBox(height: 16,),
              SizedBox(
  width: double.infinity,
  height: 62,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // 취소 버튼
      Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
  Navigator.pop(context);
},

          child: Container(
            width: 169,
            height: 40,
            alignment: Alignment.center,
            child: const Text(
              '취소',
              style: TextStyle(
                color: Color(0xFF7F8C9C),
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      // 저장 버튼
      Material(
        color: const Color(0xFF5E70FF),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            // 저장 버튼 동작
          },
          child: Container(
            width: 169,
            height: 40,
            alignment: Alignment.center,
            child: const Text(
              '저장',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}

class ReservationDetail extends StatefulWidget {
  const ReservationDetail({super.key});
  

  @override
  State<ReservationDetail> createState() => _ReservationDetailState();
}

class _ReservationDetailState extends State<ReservationDetail> {
  bool isNotificationOn = false;
  Set<int> selectedRepeatDays = {};

  final List<String> shortDayLabels = ['일', '월', '화', '수', '목', '금', '토'];

  String get repeatText {
    if (selectedRepeatDays.isEmpty) return '반복 없음';
    final sorted = selectedRepeatDays.toList()..sort();
    final labels = sorted.map((i) => shortDayLabels[i]).join(', ');
    return labels;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 21),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 반복
            
GestureDetector(
  onTap: () async {
                final result = await showRepeatDaySelector(context);
                if (result != null) {
                  setState(() {
                    selectedRepeatDays = result;
                  });
                }
              },
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        '반복',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: -1.44,
        ),
      ),
      Row(
        children: [
          Text(
  repeatText, // 동적으로 선택된 요일 표시
  style: const TextStyle(
    color: Color(0xFF575A9F),
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.28,
  ),
),

          const SizedBox(width: 8),
          Image.asset(
            'assets/Right.png',
            width: 24,
            height: 24,
          ),
        ],
      ),
    ],
  ),
),

            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),

            // 청소모드
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '청소모드',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.44,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "미설정",
                      style: TextStyle(
                        color: Color(0xFF575A9F),
                        fontSize: 16,
                        fontFamily: 'One UI Sans APP VF',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -1.28,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/Right.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),

            // 완료 알림
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '완료 알림',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.44,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isNotificationOn = !isNotificationOn;
                    });
                  },
                  child: Container(
                    width: 48,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: isNotificationOn
                          ? const Color(0xFF5E70FF)
                          : const Color(0xFF7F8C9C),
                    ),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          left: isNotificationOn ? 24 : 3,
                          top: 3.5,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Future<Set<int>?> showRepeatDaySelector(BuildContext context) {
  return showModalBottomSheet<Set<int>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const RepeatDaySelector(), // 이 위젯 안에서 Navigator.pop(context, Set<int>) 해야 함
  );
}



class RepeatDaySelector extends StatefulWidget {
  const RepeatDaySelector({super.key});

  @override
  State<RepeatDaySelector> createState() => _RepeatDaySelectorState();
}

class _RepeatDaySelectorState extends State<RepeatDaySelector> {
  final List<String> days = [
    '매주 일요일',
    '매주 월요일',
    '매주 화요일',
    '매주 수요일',
    '매주 목요일',
    '매주 금요일',
    '매주 토요일',
  ];

  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "반복 요일 선택",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: days.length,
              separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE0E0E0)),
              itemBuilder: (context, index) {
                final isSelected = selectedIndexes.contains(index);
                return ListTile(
                  title: Text(
                    days[index],
                    style: TextStyle(
                      color: isSelected ? Color(0xFF5E70FF) : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Color(0xFF5E70FF))
                      : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedIndexes.remove(index);
                      } else {
                        selectedIndexes.add(index);
                      }
                    });
                  },
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5E70FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                      Navigator.pop(context, selectedIndexes);
                    },
                  child: const Text(
                    "확인",
                    style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class StartTime extends StatefulWidget {
  const StartTime({super.key});

  @override
  State<StartTime> createState() => _StartTimeState();
}

class _StartTimeState extends State<StartTime> {
  TimeOfDay? selectedTime;

  void _showTimePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        TimeOfDay tempTime = selectedTime ?? TimeOfDay.now();
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTime = tempTime;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      color: Color(0xFF5E70FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(
                    hours: tempTime.hour,
                    minutes: tempTime.minute,
                  ),
                  onTimerDurationChanged: (Duration newTime) {
                    tempTime = TimeOfDay(hour: newTime.inHours, minute: newTime.inMinutes % 60);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 21),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              '시작 시간',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 21),
            child: Text(
              "청소 시작 시간을 지정해 예약해보세요.",
              style: TextStyle(
                color: Color(0xFF575A9F),
                fontSize: 16,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.28,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showTimePicker,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E70FF),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  selectedTime == null
                      ? '시간 선택'
                      : '${selectedTime!.hour.toString().padLeft(2, '0')} : ${selectedTime!.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
