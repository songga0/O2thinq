import 'package:flutter/material.dart';

class MapFixPage extends StatelessWidget {
  final String spaceTitle;

  const MapFixPage({super.key, required this.spaceTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: Text('$spaceTitle 지도 수정'),
        backgroundColor: const Color(0xFFEFF1F4),
      ),
      body: const SingleChildScrollView(
        child: MapWhere(),
      ),
    );
  }
}


class MapWhere extends StatefulWidget {
  const MapWhere({super.key});

  @override
  State<MapWhere> createState() => _MapWhereState();
}

class _MapWhereState extends State<MapWhere> {
  int selectedTagIndex = 0;
  int? selectedAreaIndex;

  @override
  Widget build(BuildContext context) {
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
                _buildTextField('도면 1'),
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
                _buildAreaPreview(),
              ],
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFB0B0B0),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (_) {
                return Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B6B),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
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
