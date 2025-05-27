import 'package:flutter/material.dart';
import 'package:o2thinq/device.dart';
import 'package:o2thinq/home.dart';
import 'package:o2thinq/menu.dart';
import 'package:o2thinq/report.dart';
import 'package:permission_handler/permission_handler.dart'; // ✅ 추가


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    DevicePage(),
    ReportPage(),
    MenuPage(),
  ];

  final List<String> _tabLabels = ['홈', '디바이스', '리포트', '메뉴'];
  final Map<String, String> _tabIcons = {
    '홈': 'Home',
    '디바이스': 'Device',
    '리포트': 'Report',
    '메뉴': 'Menu',
  };

  @override
  void initState() {
    super.initState();
    _requestPermissions(); // ✅ 권한 요청
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    if (statuses.values.any((status) => status.isDenied || status.isPermanentlyDenied)) {
      print("❌ 일부 권한이 거부됨. 설정 화면으로 이동합니다.");
      openAppSettings(); // 앱 설정 열기
    } else {
      print("✅ 권한 모두 허용됨");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFFEFF1F4),
          elevation: 0,
          flexibleSpace: const SafeArea(
            child: TopNav(),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_tabLabels.length, (index) {
            String key = _tabIcons[_tabLabels[index]]!;
            return _buildNavItem(
              label: _tabLabels[index],
              isActive: _currentIndex == index,
              activeIcon: '${key}_Active.png',
              defaultIcon: '${key}_Default.png',
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String label,
    required bool isActive,
    required String activeIcon,
    required String defaultIcon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/${isActive ? activeIcon : defaultIcon}'),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                letterSpacing: -0.84,
                fontFamily: 'One UI Sans APP VF',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopNav extends StatelessWidget {
  const TopNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text(
                '송가영',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.66,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '홈', // 고정
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.66,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(width: 20, height: 20, child: Image.asset('assets/Botton.png')),
            ],
          ),
          Opacity(
            opacity: 0.70,
            child: Row(
              children: [
                SizedBox(width: 24, height: 24, child: Image.asset('assets/Add.png')),
                const SizedBox(width: 16),
                SizedBox(width: 24, height: 24, child: Image.asset('assets/Noti.png')),
                const SizedBox(width: 16),
                SizedBox(width: 24, height: 24, child: Image.asset('assets/More.png')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
