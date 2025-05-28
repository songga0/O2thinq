import 'dart:async';
import 'dart:convert';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleController {
  static final BleController _instance = BleController._internal();
  factory BleController() => _instance;
  BleController._internal();

  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription<ConnectionStateUpdate>? _connection;
  
  bool isConnecting = false;
  bool isConnected = false;

  static const targetId = "B4:52:A9:13:D4:51";
  static final Uuid serviceUuid = Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb");
  static final Uuid characteristicUuid = Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb");

  Future<void> connect() async {
    if (isConnected || isConnecting) return;

    isConnecting = true;

    _connection = flutterReactiveBle.connectToDevice(id: targetId).listen(
      (state) {
        if (state.connectionState == DeviceConnectionState.connected) {
          isConnected = true;
          isConnecting = false;
          print("✅ BLE 연결됨");
        } else if (state.connectionState == DeviceConnectionState.disconnected) {
          isConnected = false;
          isConnecting = false;
          print("❌ BLE 연결 끊김");
        }
      },
      onError: (error) {
        isConnected = false;
        isConnecting = false;
        print("⚠️ 연결 실패: $error");
      },
    );
  }

  Future<void> sendString(String data) async {
    if (!isConnected) {
      print("⚠️ 전송 실패: BLE 미연결 상태");
      return;
    }

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
      print("✅ 전송됨: $data");
    } catch (e) {
      print("⚠️ 전송 실패: $e");
    }
  }

  void dispose() {
    _connection?.cancel();
  }
}
