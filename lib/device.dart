import 'package:flutter/material.dart';
import 'package:o2thinq/ble.dart';
import 'device_detail.dart'; // 반드시 추가!

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderSection(),
            SizedBox(height: 16),
            Devicelist(title: '부엌'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            '모든 공간',
            style: TextStyle(
              color: Color(0xFF7E8999),
              fontSize: 14,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.98,
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              'assets/ListBotton.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class Devicelist extends StatelessWidget {
  final String title;
  const Devicelist({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17.45,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.35,
            ),
          ),
        ),
        const SizedBox(height: 9),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: const [
              DeviceCard(deviceName: '브릭봇'),
            ],
          ),
        ),
      ],
    );
  }
}

class DeviceCard extends StatefulWidget {
  final String deviceName;
  const DeviceCard({super.key, required this.deviceName});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool _isSelected = false;
  bool _isImageOn = false;

  final BleController bleController = BleController();

  void _toggleImage() async {
    setState(() {
      _isImageOn = !_isImageOn;
    });

    if (bleController.isConnected) {
      try {
        if (_isImageOn) {
          await bleController.sendString('on\r\n');
        } else {
          await bleController.sendString('off\r\n');
        }
      } catch (e) {
        print("BLE 전송 중 오류: $e");
      }
    } else {
      print("BLE 연결 안됨. 연결 후 다시 시도하세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailPage(deviceName: widget.deviceName),
          ),
        );
      },
      child: Container(
        width: 170,
        height: 114,
        decoration: ShapeDecoration(
          color: _isSelected ? const Color(0xFFC4C4C4) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.countertops,
                    size: 40,
                    color: Color(0xFF4A58BB),
                  ),
                  GestureDetector(
                    onTap: _toggleImage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            _isImageOn
                                ? 'assets/card_device_on.png'
                                : 'assets/card_device_off.png',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.deviceName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.32,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    _isImageOn ? '켜짐' : '꺼짐',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.24,
                    ),
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
