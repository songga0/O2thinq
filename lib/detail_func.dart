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
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 352,
                    child: Text(
                      '기능 설정',
                      style: TextStyle(
                        color: const Color(0xFF606A76),
                        fontSize: 17.45,
                        fontFamily: 'One UI Sans APP VF',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.35,
                      )
                    )
                  )
                ]
              ),SizedBox(height: 12,),
              FuncSetting(),
              SizedBox(height: 12,),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      '설정 초기화',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF606A76),
                        fontSize: 17.45,
                        fontFamily: 'One UI Sans APP VF',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.35,
                      )
                    )
                  ),
                ]
              ),SizedBox(height: 12,),
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
              ),SizedBox(height: 55,)
            ],
          ),
        ),
      ),
    );
  }
}


class FuncSetting extends StatefulWidget {
  const FuncSetting({super.key});

  @override
  _FuncSettingState createState() => _FuncSettingState();
}

class _FuncSettingState extends State<FuncSetting> {
  double _sliderBrushValue = 0.5;  // 슬라이더 초기 값 (0.0 ~ 1.0)
  int _selectedStrengthIndex = 2;  // 기본값 '중' (0: 약, 1: 중약, 2: 중, 3: 중강, 4: 강)
  double _steamquantityValue = 0.5; 
  double _waterquantityValue = 0.5; 
  int _selectedTurnIndex = 2; 

  String _strengthLabel = '중';  // 흡입력 텍스트 (초기값은 '중')
  bool isOn = false; // 고온 스팀 상태 (on/off)
  String _turnLabel = '중';

  String getBrushSpeedText() {
    if (_sliderBrushValue <= 0.2) {
      return '매우 느림';
    } else if (_sliderBrushValue <= 0.4) {
      return '느림';
    } else if (_sliderBrushValue <= 0.6) {
      return '보통';
    } else if (_sliderBrushValue <= 0.8) {
      return '빠름';
    } else {
      return '매우 빠름';
    }
  }

  String steamquantity() {
    if (_steamquantityValue <= 0.2) {
      return '매우 적음';
    } else if (_steamquantityValue <= 0.4) {
      return '적음';
    } else if (_steamquantityValue <= 0.6) {
      return '보통';
    } else if (_steamquantityValue <= 0.8) {
      return '많음';
    } else {
      return '매우 많음';
    }
  }

  String waterquantity() {
    if (_waterquantityValue <= 0.2) {
      return '매우 적음';
    } else if (_waterquantityValue <= 0.4) {
      return '적음';
    } else if (_waterquantityValue <= 0.6) {
      return '보통';
    } else if (_waterquantityValue <= 0.8) {
      return '많음';
    } else {
      return '매우 많음';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '회전 브러쉬 속도 (쓸기)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              getBrushSpeedText(),
              style: TextStyle(
                color: const Color(0xFF575A9F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.12,
              ),
            ),
          ),
          Slider(
            value: _sliderBrushValue,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _sliderBrushValue = value;
              });
            },
            activeColor: const Color(0xFF5E70FF),
            inactiveColor: const Color(0xFFF0F1F5),
            thumbColor: const Color(0xFF5E70FF),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
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
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '흡입력 조절',  // 흡입력 텍스트 업데이트
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              _strengthLabel,
              style: TextStyle(
                color: const Color(0xFF575A9F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.12,
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 21),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStrengthItem(0, '약'),
                _buildStrengthItem(1, '중약'),
                _buildStrengthItem(2, '중'),
                _buildStrengthItem(3, '중강'),
                _buildStrengthItem(4, '강'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '고온 스팀',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'One UI Sans APP VF',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1.44,
                        ),
                      ),
                      SizedBox(height: 4), // 텍스트 간격
                      Text(
                        '기본 스팀보다 더 높은 살균력을 자랑해요',
                        style: TextStyle(
                          color: const Color(0xFF575A9F),
                          fontSize: 14,
                          fontFamily: 'One UI Sans APP VF',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1.12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOn = !isOn;
                    });
                  },
                  child: Container(
                    width: 48, // 고정된 크기
                    height: 28, // 고정된 크기
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: isOn ? const Color(0xFF5E70FF) : const Color(0xFF7F8C9C), // 상태에 따른 색상
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: isOn ? 24 : 3, // 상태에 따라 스위치의 위치 조정
                          top: 4,
                          child: Container(
                            width: 21,
                            height: 21,
                            decoration: BoxDecoration(
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
          ),SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '스팀 분사량',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              steamquantity(),
              style: TextStyle(
                color: const Color(0xFF575A9F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.12,
              ),
            ),
          ),
          Slider(
            value: _steamquantityValue,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _steamquantityValue = value;
              });
            },
            activeColor: const Color(0xFF5E70FF),
            inactiveColor: const Color(0xFFF0F1F5),
            thumbColor: const Color(0xFF5E70FF),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '적음',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C9C),
                  ),
                ),
                Text(
                  '많음',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C9C),
                  ),
                ),
              ],
            ),
          ),SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '걸레 물 공급',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              waterquantity(),
              style: TextStyle(
                color: const Color(0xFF575A9F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.12,
              ),
            ),
          ),
          Slider(
            value: _waterquantityValue,
            min: 0.0,
            max: 1.0,
            onChanged: (value) {
              setState(() {
                _waterquantityValue = value;
              });
            },
            activeColor: const Color(0xFF5E70FF),
            inactiveColor: const Color(0xFFF0F1F5),
            thumbColor: const Color(0xFF5E70FF),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '적음',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C9C),
                  ),
                ),
                Text(
                  '많음',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C9C),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '걸레 회전 조절(닦기)',  // 흡입력 텍스트 업데이트
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.44,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              _turnLabel,
              style: TextStyle(
                color: const Color(0xFF575A9F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.12,
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 21),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTurnItem(0, '약'),
                _buildTurnItem(1, '중약'),
                _buildTurnItem(2, '중'),
                _buildTurnItem(3, '중강'),
                _buildTurnItem(4, '강'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTurnItem(int index, String label) {
    bool isSelected = _selectedTurnIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTurnIndex = index;
          // 흡입력 텍스트 변경
          switch (index) {
            case 0:
              _turnLabel = '약';
              break;
            case 1:
              _turnLabel = '중약';
              break;
            case 2:
              _turnLabel = '중';
              break;
            case 3:
              _turnLabel = '중강';
              break;
            case 4:
              _turnLabel = '강';
              break;
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: ShapeDecoration(
              color: isSelected ? const Color(0xFF5E70FF) : const Color(0xFF7F8C9C),
              shape: OvalBorder(),
            ),
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: isSelected ? Colors.white : const Color(0xFF7F8C9C),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          SizedBox(height: 6), // 간격 추가
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w400,
              letterSpacing: -1.44,
            ),
          ),
        ],
      ),
    );
  }



  // 선택된 상태에 따라 버튼의 색상 및 원 안에 있는 원을 변경
  Widget _buildStrengthItem(int index, String label) {
    bool isSelected = _selectedStrengthIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStrengthIndex = index;
          // 흡입력 텍스트 변경
          switch (index) {
            case 0:
              _strengthLabel = '약';
              break;
            case 1:
              _strengthLabel = '중약';
              break;
            case 2:
              _strengthLabel = '중';
              break;
            case 3:
              _strengthLabel = '중강';
              break;
            case 4:
              _strengthLabel = '강';
              break;
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: ShapeDecoration(
              color: isSelected ? const Color(0xFF5E70FF) : const Color(0xFF7F8C9C),
              shape: OvalBorder(),
            ),
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: ShapeDecoration(
                  color: isSelected ? Colors.white : const Color(0xFF7F8C9C),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          SizedBox(height: 6), // 간격 추가
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w400,
              letterSpacing: -1.44,
            ),
          ),
        ],
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
     clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15), // 상단과 아래 패딩 설정
            child: 
                Text(
                  '로봇 이동 속도',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.44,
                  ),
                ),),
                 Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15), // 상단과 아래 패딩 설정
            child: 
                Text(
                  getSpeedText(),
                  style: TextStyle(
                    color: const Color(0xFF575A9F),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.12,
                  ),
                ),),
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
          ), Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15), // 상단과 아래 패딩 설정
            child: 
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
          ),),
        ],
      ),
    );
  }
}
