import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ble.dart';  // 새로 만든 BleController import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BleController bleController = BleController();
  final TextEditingController _textController = TextEditingController();

  bool isScanning = false;
  bool foundTargetDevice = false;

  @override
  void initState() {
    super.initState();
    _initBleOnHomeOpen();
  }

  Future<void> _initBleOnHomeOpen() async {
    await _requestPermissions();
    // bleController 내부에 스캔 기능 추가해도 되고, 우선은 연결만 시도
    await bleController.connect();
    setState(() {}); // 상태 갱신
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    if (statuses.values.any((status) => status.isDenied || status.isPermanentlyDenied)) {
      openAppSettings();
    }
  }

  Future<void> _send() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    await bleController.sendString(text + '\n');
    _textController.clear();
  }

  @override
  void dispose() {
    bleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final connected = bleController.isConnected;
    final connecting = bleController.isConnecting;

    return Center(
      child: connected
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '✅ 연결됨! 텍스트를 입력하세요:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '전송할 텍스트',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _send,
                        child: const Text('전송'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  connecting ? '🔄 연결 중...' : '🔍 BLE 기기 연결 중...',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                if (connecting) const CircularProgressIndicator(),
              ],
            ),
    );
  }
}
