import 'package:flutter/material.dart';
import 'package:o2thinq/cleaner.dart';
import 'package:o2thinq/draw_map.dart';
import 'package:o2thinq/map.dart';

class MapFixPage extends StatelessWidget {
  final String spaceTitle;

  const MapFixPage({super.key, required this.spaceTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: Text('수정하기'),
        backgroundColor: const Color(0xFFEFF1F4),
      ),
      body: SingleChildScrollView(
        child: MapWhere(spaceTitle: spaceTitle),
      ),
    );
  }
}

class MapWhere extends StatefulWidget {
  final String spaceTitle;
  const MapWhere({super.key, required this.spaceTitle});

  @override
  State<MapWhere> createState() => _MapWhereState();
}

class _MapWhereState extends State<MapWhere> {
  int selectedTagIndex = 0;
  int? selectedAreaIndex;

  @override
  Widget build(BuildContext context) {
    // 공간 이름에 따라 맵 데이터 선택
    final mapData = widget.spaceTitle == '싱크대' ? kitchen : table;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(21, 16, 21, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('이름'),
                const SizedBox(height: 12),
                _buildTextField(widget.spaceTitle),
                const SizedBox(height: 20),
                _buildLabel('영역'),
                const SizedBox(height: 8),
                const Text(
                  '수정할 영역을 선택하고 손으로 드래그 해보세요.',
                  style: TextStyle(
                    color: Color(0xFF575A9F),
                    fontSize: 14,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.12,
                  ),
                ),
                const SizedBox(height: 12),
                _buildTagList(),
                const SizedBox(height: 12),
                _buildConditionalAreaPreview(),
                const SizedBox(height: 12),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    DrawMap(mapData),
                    Positioned(
                      top: 10,
                      left: -6,
                      child: CleanerBottom(),
                    ),
                    Positioned(
                      top: 11,
                      left: -4,
                      child: Cleaner(),
                    ),
                    Positioned(
                      top: 12,
                      left: 2,
                      child: CleanerTop(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 310,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 310,
                        height: 1,
                        decoration: const BoxDecoration(color: Color(0xFFF0F1F5)),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: _buildLegendItem(color: Color(0xFFFF705E), label: '기름때 집중 케어')),
                              Expanded(child: _buildLegendItem(color: Color(0xFF5E70FF), label: '물때 집중 케어')),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: _buildLegendItem(color: Color(0xFF9E9E9E), label: '청소 금지 구역')),
                              Expanded(child: _buildLegendItem(color: Color(0xFF21FF15), label: '부스러기 집중 케어')),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 350,
                child: Text(
                  '도면 삭제하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF606A76),
                    fontSize: 17.45,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.35,
                  ),
                ),
              ),
              
              const SizedBox(height: 26),
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
              
              const SizedBox(height: 44),
            ],
          ),
        
      
    );
  }

  

Widget _buildLegendItem({required Color color, required String label}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12), // ← 여기서 왼쪽 패딩을 설정!
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 34,
          height: 12,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF606A76),
            fontSize: 12,
            fontFamily: 'One UI Sans APP VF',
            fontWeight: FontWeight.w400,
            letterSpacing: -1.08,
          ),
        ),
      ],
    ),
  );
}





  


  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'One UI Sans APP VF',
        fontWeight: FontWeight.w400,
        letterSpacing: -1.44,
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF646B7B),
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
          letterSpacing: -1.44,
        ),
        filled: true,
        fillColor: const Color(0xFFF0F1F5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withAlpha(26), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black.withAlpha(26), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildTag(String text, int index) {
    bool isSelected = selectedTagIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTagIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 11),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6ECFF3) : const Color(0xFFF0F1F5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF646B7B),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.96,
          ),
        ),
      ),
    );
  }

  Widget _buildTagList() {
    final tags = [
      '면적 수정',
      '기름때 집중 케어',
      '물때 집중 케어',
      '부스러기 집중 케어',
      '청소 금지 구역',
    ];
    return SizedBox(
      height: 27,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return _buildTag(tags[index], index);
        },
      ),
    );
  }

Widget _buildConditionalAreaPreview() {
  if (selectedTagIndex == 0) {
    return _buildAreaPreview();
  }  
  else {
    return _buildOilAreaPreview();
  }
}

Widget _buildOilAreaPreview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F5),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildOilAreaCard(index: 0, label: '추가하기', content: _oilContent()),
          
        ],
      ),
    );
  }
 Widget _oilContent() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 20,
            color: Color(0xFF646B7B), // 아이콘 색상 (원하는 색으로 변경 가능)
          ),
        ),
      ),
    ],
  );
}



  Widget _buildOilAreaCard({required int index, required String label, required Widget content}) {
  final isSelected = selectedAreaIndex == index;

  return GestureDetector(
    onTap: () {
      setState(() {
        if (isSelected) {
          selectedAreaIndex = null; // 다시 클릭하면 선택 해제
        } else {
          selectedAreaIndex = index;
        }
      });
    },
    child: Row(
      children: [
        IntrinsicWidth(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6ECFF3) : Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                content,
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.08,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}



  Widget _buildAreaPreview() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F5),
        borderRadius: BorderRadius.circular(8),
      ),
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAreaCard(index: 0, label: '싱크대', content: _sinkContent()),
          _buildAreaCard(index: 1, label: '인덕션', content: _inductionContent()),
          _buildAreaCard(index: 2, label: '전자레인지', content: _microwaveContent()),
          _buildAreaCard(index: 3, label: '오븐', content: _ovenContent()),
        ],
      ),
    );
  }

  Widget _buildAreaCard({required int index, required String label, required Widget content}) {
  final isSelected = selectedAreaIndex == index;
  return GestureDetector(
    onTap: () {
      setState(() {
        selectedAreaIndex = index;
      });
    },
    child: Row(
      children: [
        IntrinsicWidth(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6ECFF3) : Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                content,
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.08,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}

  // 개별 카드 내용 위젯
  Widget _sinkContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: Color(0xFFF4F4F4),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 60,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFCACACA),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _inductionContent() {
  return SizedBox(
    width: 60,
    height: 40,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // 뒷배경 원형 (중앙의 회색 원)
        Container(
          width: 18,
          height: 18,
          decoration: const ShapeDecoration(
            color: Color(0xFFCACACA),
            shape: OvalBorder(),
          ),
        ),
        // 앞쪽 컴포넌트 전체
        Container(
          width: 60,
          height: 40,
          decoration: ShapeDecoration(
            color: const Color(0xFFF3F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상단 큰 원
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFCACACA),
                      shape: OvalBorder(),
                    ),
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF3F3F3),
                      shape: OvalBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // 하단 두 개의 작은 원
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFCACACA),
                          shape: OvalBorder(),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF3F3F3),
                          shape: OvalBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFCACACA),
                          shape: OvalBorder(),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF3F3F3),
                          shape: OvalBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



  Widget _microwaveContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFB0B0B0),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB0B0B0),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ovenContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFB0B0B0),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (_) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB0B0B0),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
