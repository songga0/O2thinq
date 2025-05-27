import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? scanStream;
  StreamSubscription<ConnectionStateUpdate>? connection;

  final TextEditingController _textController = TextEditingController();

  bool isScanning = false;
  bool foundTargetDevice = false;
  bool isConnecting = false;
  bool isConnected = false;

  static const targetId = "B4:52:A9:13:D4:51";

  static final Uuid serviceUuid =
      Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb");
  static final Uuid characteristicUuid =
      Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb");

  @override
  void initState() {
    super.initState();
    _initBleOnHomeOpen();
  }

  Future<void> _initBleOnHomeOpen() async {
    await _requestPermissions();
    startScan();
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

  void startScan() {
    if (isScanning || isConnected || isConnecting) return;

    setState(() {
      isScanning = true;
      foundTargetDevice = false;
    });

    scanStream = flutterReactiveBle.scanForDevices(withServices: []).listen(
      (device) {
        if (device.id == targetId && !foundTargetDevice) {
          setState(() {
            foundTargetDevice = true;
          });
          stopScan();
          connectToDevice();
        }
      },
      onError: (error) {
        print("스캔 에러: $error");
      },
    );

    Future.delayed(const Duration(seconds: 5), stopScan);
  }

  void stopScan() {
    scanStream?.cancel();
    setState(() {
      isScanning = false;
    });
  }

  void connectToDevice() {
    if (isConnected || isConnecting) return;

    setState(() {
      isConnecting = true;
    });

    connection = flutterReactiveBle.connectToDevice(id: targetId).listen(
      (state) {
        if (state.connectionState == DeviceConnectionState.connected) {
          setState(() {
            isConnected = true;
            isConnecting = false;
          });
          print("✅ 연결 완료");
        } else if (state.connectionState == DeviceConnectionState.disconnected) {
          setState(() {
            isConnected = false;
            isConnecting = false;
          });
          print("❌ 연결 끊김");
        }
      },
      onError: (error) {
        setState(() {
          isConnected = false;
          isConnecting = false;
        });
        print("연결 에러: $error");
      },
    );
  }

  Future<void> sendStringToDevice(String data) async {
    if (!isConnected) return;

    try {
      final bytes = utf8.encode(data);
      await flutterReactiveBle.writeCharacteristicWithResponse(
        QualifiedCharacteristic(
          serviceId: serviceUuid,
          characteristicId: characteristicUuid,
          deviceId: targetId,
        ),
        value: bytes,
      );
      print("전송됨: $data");
    } catch (e) {
      print("전송 실패: $e");
    }
  }

  @override
  void dispose() {
    scanStream?.cancel();
    connection?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isConnected
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
                        onPressed: () {
                          final text = _textController.text.trim();
                          if (text.isNotEmpty) {
                            sendStringToDevice(text + '\n');
                            _textController.clear();
                          }
                        },
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
                const Text(
                  '🔍 BLE 기기 연결 중...',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                if (isScanning) const CircularProgressIndicator(),
              ],
            ),
    );
  }
}
