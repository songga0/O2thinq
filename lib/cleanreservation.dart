import 'package:flutter/material.dart';
import 'package:o2thinq/addreservation.dart';

class CleanReservation extends StatelessWidget {
  const CleanReservation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: const Text('청소 예약'),
        backgroundColor: const Color(0xFFEFF1F4),
        elevation: 0, // 앱바 그림자 없애기
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0), // 오른쪽 패딩 추가
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 플러스 아이콘
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddReservation()),
                    );
                  },

                ),
                const SizedBox(width: 8), // 간격
                // 설정 아이콘
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // 설정 아이콘 클릭 시의 동작
                    print('설정 아이콘 클릭됨');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  '예약된 시간',
                  style: TextStyle(
                    color: const Color(0xFF606A76),
                    fontSize: 17.45,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.35,
                  ),
                ),
              ),SizedBox(height: 12,),
              const ReservationTime(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReservationTime extends StatefulWidget {
  const ReservationTime({super.key});

  @override
  State<ReservationTime> createState() => _ReservationTimeState();
}

class _ReservationTimeState extends State<ReservationTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
