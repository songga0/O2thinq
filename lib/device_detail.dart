import 'package:flutter/material.dart';
import 'package:o2thinq/device_setting.dart';
import 'package:o2thinq/map.dart';
import 'package:o2thinq/mapfix.dart';
import 'package:o2thinq/work_setting.dart';

// 메인 페이지
class DeviceDetailPage extends StatefulWidget{
  final String deviceName;
  const DeviceDetailPage({super.key, required this.deviceName});

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  // 0: 작동설정, 1: 기기관리
  int selectedIndex = 0;
  
  

  void onTabChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    Widget bottomBar;
    if (selectedIndex == 0) {
      bottomBar = Property1ProdcutDetailPage(onTabChanged: onTabChanged);
    } else {
      bottomBar = Property1Variant2(onTabChanged: onTabChanged);
    }

    return Scaffold(
      appBar: TopNav2(deviceName: widget.deviceName),
      backgroundColor: const Color(0xFFEFF1F4),
      body: Stack(
        children: [
          // 탭에 따른 메인 컨텐츠
          Positioned.fill(
            top: 0,
            bottom: 62, // bottomBar 높이 만큼 빼줌
            child: selectedIndex == 0
                ? const ProductDetailContent()
                : const DeviceSetting(), // 기기관리 탭은 빈 화면, 필요시 추가 구현
          ),

          // 하단 탭 바
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: bottomBar,
            ),
          ),
        ],
      ),
    );
  }
}

// 상단 네비게이션 바
class TopNav2 extends StatelessWidget implements PreferredSizeWidget {
  final String deviceName;

  const TopNav2({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(color: Color(0xFFEFF1F4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // 뒤로가기
                  },
                  child: Image.asset(
                    'assets/Arrow_Left_Gray.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  deviceName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.66,
                  ),
                ),
              ],
            ),
            Image.asset('assets/Setting_Gray.png', width: 24, height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

// 하단 탭 - 작동설정 탭 버튼 영역 (이전 '제품')
class Property1ProdcutDetailPage extends StatelessWidget {
  final void Function(int) onTabChanged;

  const Property1ProdcutDetailPage({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      color: const Color(0xFFEFF1F4),
      child: Stack(
        children: [
          Positioned(
            left: 79,
            top: 12,
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                width: 234,
                height: 38,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 194,
            top: 12,
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                width: 119,
                height: 38,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 229,
            top: 22,
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: const Text(
                '기기관리',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF646B7B),
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.84,
                ),
              ),
            ),
          ),
          Positioned(
            left: 79,
            top: 12,
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                width: 119,
                height: 38,
                decoration: ShapeDecoration(
                  color: const Color(0xFF405574),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 113,
            top: 22,
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: const Text(
                '작동설정',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFFCFFFF),
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.84,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 하단 탭 - 기기관리 탭 버튼 영역 (이전 '유용한 기능')
class Property1Variant2 extends StatelessWidget {
  final void Function(int) onTabChanged;

  const Property1Variant2({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      color: const Color(0xFFEFF1F4),
      child: Stack(
        children: [
          Positioned(
            left: 79,
            top: 12,
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                width: 234,
                height: 38,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 79,
            top: 12,
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                width: 119,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white, // 배경색
                  border: Border.all(width: 1, color: Colors.white), // 테두리
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
            ),
          ),
          Positioned(
            left: 113,
            top: 22,
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: const Text(
                '작동설정',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF646B7B),
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.84,
                ),
              ),
            ),
          ),
          Positioned(
            left: 194,
            top: 12,
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                width: 119,
                height: 38,
                decoration: ShapeDecoration(
                  color: const Color(0xFF405574),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 229,
            top: 22,
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: const Text(
                '기기관리',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.84,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 작동설정 탭 선택 시 나오는 실제 상세 내용 위젯 (이전 '제품')
class ProductDetailContent extends StatefulWidget {
  const ProductDetailContent({super.key});

  @override
  State<ProductDetailContent> createState() => _ProductDetailContentState();
}

class _ProductDetailContentState extends State<ProductDetailContent> {
  late List<List<int>> selectedMap;
  late String selectedTitle;

  @override
  void initState() {
    super.initState();
    selectedMap = kitchen; // 초기값 설정
    selectedTitle = '싱크대'; // 초기값 설정
  }

  void onMapSelected(String title, List<List<int>> mapData) {
    setState(() {
      selectedTitle = title;
      selectedMap = mapData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 21),
          child: SizedBox(
            height: 23,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '청소 영역',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.45,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.35,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 360,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CleanSpace(
  title: '싱크대',
  icon: Icons.soup_kitchen,
  mapData: kitchen,
  onMapTap: onMapSelected,
),
CleanSpace(
  title: '식탁',
  icon: Icons.restaurant,
  mapData: table,
  onMapTap: onMapSelected,
),

              SizedBox(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 12),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Container(
          height: 321,
          width: 334,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapFixPage(spaceTitle: "New",map: [],),
                  ),
                );
              },
              child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            children: const [
              Text(
                '아직 도면이 없어요.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -1.44,
                ),
              ),
              SizedBox(height: 4), // 텍스트 간 간격
              Text.rich(
  TextSpan(
    style:  TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'One UI Sans APP VF',
      fontWeight: FontWeight.w500,
      letterSpacing: -1.44,
    ),
    children:  [
      TextSpan(text: '브릭봇', style: TextStyle(color: Color(0xFF6ECFF3))),
      TextSpan(text: '을 '),
      TextSpan(text: '좌측 상단', style: TextStyle(color: Color(0xFF6ECFF3))),
      TextSpan(text: '에 놓고'),
    ],
  ),
),

Text.rich(
  TextSpan(
    style:  TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontFamily: 'One UI Sans APP VF',
      fontWeight: FontWeight.w500,
      letterSpacing: -1.44,
    ),
    children:  [
      TextSpan(text: '청소 시작', style: TextStyle(color: Color(0xFF6ECFF3))),
      TextSpan(text: '을 눌러주세요'),
    ],
  ),
),

              ]))
            ),
          ),
        ),
      ),
    ],
  ),
)


            ],
          ),
        ),
        CleanMode(spaceTitle: selectedTitle,map:selectedMap ),
        const SizedBox(height: 24),
        Container(
          height: 2,
          width: double.infinity,
          color: const Color(0xFFE3E7EE),
          margin: const EdgeInsets.symmetric(horizontal: 21),
        ),
        const SizedBox(height: 24),
        Container(
          width: 392,
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 23,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '스마트 케어',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.45,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.35,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SmartCare(),
              const SizedBox(height: 24),
              const Divider(height: 2, color: Color(0xFFE3E7EE), thickness: 2),
              const SizedBox(height: 24),
              const SizedBox(
                width: 392,
                child: Text(
                  '청소 이후 기기 케어',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.45,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.35,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AftercleanCare(),
              const SizedBox(height: 24),
              const AddService(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}