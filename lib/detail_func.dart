import 'package:flutter/material.dart';

class DetailFuncPage extends StatelessWidget {
  const DetailFuncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: const Text('세부 기능 설정'),
        backgroundColor: const Color(0xFFEFF1F4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  '브릭봇 이동 설정',
                  style: TextStyle(
                    color: const Color(0xFF606A76),
                    fontSize: 17.45,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.35,
                  ),
                ),
              ),SizedBox(height: 12,),
              MovingSetting(),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                height: 62,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 취소 버튼
                    GestureDetector(
                      child: Container(
                        width: 169,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFDADDE2)),
                        ),
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
                    const SizedBox(width: 12),
                    // 저장 버튼
                    GestureDetector(
                      child: Container(
                        width: 169,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF5E70FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
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


class MovingSetting extends StatefulWidget {
  const MovingSetting({super.key});

  @override
  _MovingSettingState createState() => _MovingSettingState();
}

class _MovingSettingState extends State<MovingSetting> {
  double _sliderValue = 0.5;  // 슬라이더 초기 값 (0.0 ~ 1.0)

  String getSpeedText() {
    if (_sliderValue <= 0.2) {
      return '매우 느림';
    } else if (_sliderValue <= 0.4) {
      return '느림';
    } else if (_sliderValue <= 0.6) {
      return '보통';
    } else if (_sliderValue <= 0.8) {
      return '빠름';
    } else {
      return '매우 빠름';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '로봇 이동 속도',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.44,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  getSpeedText(),
                  style: TextStyle(
                    color: const Color(0xFF575A9F),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.12,
                  ),
                ),
              ],
            ),
          ),
          Slider(
            value: _sliderValue,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
            activeColor: const Color(0xFF5E70FF), // 파란 동그라미 색
            inactiveColor: const Color(0xFFF0F1F5), // 회색 트랙 색
            thumbColor: const Color(0xFF5E70FF), // 파란 동그라미 색
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '느림',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7F8C9C),
                ),
              ),
              Text(
                '빠름',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7F8C9C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
