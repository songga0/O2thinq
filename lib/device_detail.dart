import 'package:flutter/material.dart';
import 'package:o2thinq/work_setting.dart';

class DeviceDetailPage extends StatelessWidget {
  final String deviceName;

  const DeviceDetailPage({super.key, required this.deviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNav2(deviceName: deviceName),  
      backgroundColor: const Color(0xFFEFF1F4),
      body: Column(children: [
        CleanSpace(),
        SizedBox(height: 12,),

        ],)
    );
  }
}

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
