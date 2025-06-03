import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:o2thinq/ble.dart';
import 'package:o2thinq/cleaner.dart';
import 'package:o2thinq/cleanreservation.dart';
import 'package:o2thinq/detail_func.dart';
import 'package:o2thinq/draw_map.dart';
import 'package:o2thinq/map.dart';
import 'package:o2thinq/mapfix.dart';

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CleanSpace extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<List<int>> mapData;

  const CleanSpace({
    super.key,
    required this.title,
    required this.icon,
    required this.mapData,
  });

  @override
  State<CleanSpace> createState() => _CleanSpaceState();
}

class _CleanSpaceState extends State<CleanSpace> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final GlobalKey _mapKey = GlobalKey();
  double _mapWidth = 100;
  double _mapHeight = 100;

  static const double _initLeft = -4;
  static const double _initTop = 11;

  List<math.Point<int>> _path = [];
  Offset _currentPos = Offset.zero;
  double _currentAngle = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? box = _mapKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        setState(() {
          _mapWidth = box.size.width;
          _mapHeight = box.size.height;

          // 1. 출발점(0,0)에서 가장 먼 1 지점까지 경로 구하기
          final pathToFarthest = findFarthestOneWithPath(widget.mapData);

          if (pathToFarthest == null || pathToFarthest.isEmpty) return;

          final farthestPoint = pathToFarthest.last;

          // 2. 가장 먼 지점에서 출발점(0,0)으로 돌아오는 최단 경로 구하기
          final returnPath = findShortestPath(widget.mapData, farthestPoint, math.Point(0, 0));

          if (returnPath == null || returnPath.isEmpty) {
            // 돌아오는 경로가 없으면 단방향 경로만 사용
            _path = pathToFarthest;
          } else {
            // 왕복 경로 생성 (중복되는 지점 제거 위해 returnPath 첫 점 skip)
            _path = [...pathToFarthest, ...returnPath.skip(1)];
          }

          double cellWidth = _mapWidth / widget.mapData[0].length;
          double cellHeight = _mapHeight / widget.mapData.length;

          _controller.duration = Duration(seconds: _path.length * 2);

          _controller.addListener(() {
            setState(() {
              double progress = _controller.value * (_path.length - 1);
              int index = progress.floor();
              double t = progress - index;

              if (index < _path.length - 1) {
                final p1 = _path[index];
                final p2 = _path[index + 1];
                double dx = lerpDouble(p1.y * cellWidth, p2.y * cellWidth, t)!;
                double dy = lerpDouble(p1.x * cellHeight, p2.x * cellHeight, t)!;
                _currentPos = Offset(dx, dy);

                // 방향 각도 계산 (y좌표 차이, x좌표 차이 순서 유의)
                double angle = math.atan2(
                  (p2.x - p1.x).toDouble(),
                  (p2.y - p1.y).toDouble(),
                );
                _currentAngle = angle;
              }
            });
          });

          _controller.repeat(reverse: false);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 가장 먼 1 지점까지 경로 찾기 (기존 함수)
  List<math.Point<int>>? findFarthestOneWithPath(List<List<int>> mapData) {
    final int rows = mapData.length;
    final int cols = mapData[0].length;

    if (mapData[0][0] != 1) return null;

    final visited = List.generate(rows, (_) => List.filled(cols, false));
    final parent = List.generate(rows, (_) => List<math.Point<int>?>.filled(cols, null));
    final dist = List.generate(rows, (_) => List.filled(cols, 0));

    List<math.Point<int>> queue = [];
    int head = 0;

    queue.add(math.Point(0, 0));
    visited[0][0] = true;

    math.Point<int>? farthestPoint = math.Point(0, 0);
    int maxDist = 0;

    final directions = [
      math.Point(-1, 0),
      math.Point(1, 0),
      math.Point(0, -1),
      math.Point(0, 1),
    ];

    while (head < queue.length) {
      final current = queue[head];
      head++;

      final currentDist = dist[current.x][current.y];

      if (currentDist > maxDist) {
        maxDist = currentDist;
        farthestPoint = current;
      }

      for (final dir in directions) {
        final nx = current.x + dir.x;
        final ny = current.y + dir.y;

        if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
          if (!visited[nx][ny] && mapData[nx][ny] == 1) {
            visited[nx][ny] = true;
            dist[nx][ny] = currentDist + 1;
            parent[nx][ny] = current;
            queue.add(math.Point(nx, ny));
          }
        }
      }
    }

    if (farthestPoint == null || farthestPoint == math.Point(0, 0)) return null;

    List<math.Point<int>> path = [];
    math.Point<int>? step = farthestPoint;
    while (step != null) {
      path.add(step);
      step = parent[step.x][step.y];
    }

    return path.reversed.toList();
  }

  // 임의 시작-끝점 간 최단 경로 찾기 (새로 추가한 함수)
  List<math.Point<int>>? findShortestPath(
      List<List<int>> mapData,
      math.Point<int> start,
      math.Point<int> end,
  ) {
    final int rows = mapData.length;
    final int cols = mapData[0].length;

    if (mapData[start.x][start.y] != 1 || mapData[end.x][end.y] != 1) {
      return null;
    }

    final visited = List.generate(rows, (_) => List.filled(cols, false));
    final parent = List.generate(rows, (_) => List<math.Point<int>?>.filled(cols, null));

    List<math.Point<int>> queue = [];
    int head = 0;

    queue.add(start);
    visited[start.x][start.y] = true;

    final directions = [
      math.Point(-1, 0),
      math.Point(1, 0),
      math.Point(0, -1),
      math.Point(0, 1),
    ];

    while (head < queue.length) {
      final current = queue[head];
      head++;

      if (current == end) {
        List<math.Point<int>> path = [];
        math.Point<int>? step = end;
        while (step != null) {
          path.add(step);
          step = parent[step.x][step.y];
        }
        return path.reversed.toList();
      }

      for (final dir in directions) {
        final nx = current.x + dir.x;
        final ny = current.y + dir.y;

        if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
          if (!visited[nx][ny] && mapData[nx][ny] == 1) {
            visited[nx][ny] = true;
            parent[nx][ny] = current;
            queue.add(math.Point(nx, ny));
          }
        }
      }
    }

    return null;
  }

  Widget _buildLegendItem(Color color, String label) {
    return Expanded(
      child: Row(
        children: [
          Container(width: 34, height: 12, color: color),
          const SizedBox(width: 12),
          Opacity(
            opacity: 0.98,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF606A76),
                fontSize: 12,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w400,
                letterSpacing: -1.08,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(widget.icon, color: const Color(0xFF4A58BB), size: 24),
                          const SizedBox(width: 10),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'One UI Sans APP VF',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1.44,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapFixPage(spaceTitle: widget.title),
                            ),
                          );
                        },
                        child: const Opacity(
                          opacity: 0.98,
                          child: Text(
                            '수정하기',
                            style: TextStyle(
                              color: Color(0xFF606A76),
                              fontSize: 16,
                              fontFamily: 'One UI Sans APP VF',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -1.44,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Stack(
                      children: [
                        DrawMapMin(key: _mapKey, widget.mapData),
                        const Positioned(top: 10, left: -6, child: CleanerBottom()),
                        if (_path.isNotEmpty)
                          Positioned(
                            top: _initTop + _currentPos.dy,
                            left: _initLeft + _currentPos.dx,
                            child: Transform.rotate(
                              angle: _currentAngle + math.pi / 2,
                              child: const Cleaner(),
                            ),
                          ),
                        const Positioned(top: 12, left: 2, child: CleanerTop()),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        _buildLegendItem(const Color(0xFFFF705E), '기름때 집중 케어'),
                        _buildLegendItem(const Color(0xFF5E70FF), '물때 집중 케어'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        _buildLegendItem(const Color(0xFF21FF15), '부스러기 집중 케어'),
                        _buildLegendItem(const Color(0xFF9E9E9E), '청소 금지 구역'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CleanMode extends StatefulWidget {
  final String spaceTitle;
  final List<List<int>> map;

  const CleanMode({
    super.key,
    required this.spaceTitle,
    required this.map,
  });

  @override
  State<CleanMode> createState() => _CleanModeState();
}

class _CleanModeState extends State<CleanMode> {
  String _selectedMode = '스마트 케어 모드';
  double _progress = 0.0;
  final BleController bleController = BleController();

  Timer? _timer;
  int _elapsedSeconds = 0;
  int _totalSeconds = 0;
  bool _isRunning = false;

  final Map<String, IconData> modeIcons = {
    '스마트 케어 모드': Icons.psychology,
    '표준 모드': Icons.cleaning_services,
    '건식 모드': Icons.air,
    '습식 모드': Icons.water_drop,
  };

  String _calculateEstimatedTime(List<List<int>> map) {
    int count = 0;
    for (var row in map) {
      count += row.where((cell) => cell == 1).length;
    }

    int secondsPerUnit;
    switch (_selectedMode) {
      case '표준 모드':
        secondsPerUnit = 8;
        break;
      case '건식 모드':
      case '습식 모드':
        secondsPerUnit = 5;
        break;
      case '스마트 케어 모드':
      default:
        secondsPerUnit = 10;
    }

    _totalSeconds = count * secondsPerUnit;
    int minutes = _totalSeconds ~/ 60;
    int seconds = _totalSeconds % 60;
    return '예상 총 소요시간 : $minutes분 $seconds초';
  }

  void _startOrPauseProgress() async {
  if (_isRunning) {
    // ✅ 일시정지
    _timer?.cancel();

    if (bleController.isConnected) {
      try {
        await bleController.sendString('pause\r\n');
      } catch (e) {
       ;
      }
    }
  } else {
    // ✅ 시작 or 이어하기
    if (_elapsedSeconds == 0 && _totalSeconds == 0) {
      _calculateEstimatedTime(widget.map); // 시간 계산
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        _progress = _elapsedSeconds / _totalSeconds;

        if (_progress >= 1.0) {
          _progress = 1.0;
          _isRunning = false;
          timer.cancel();

          // ✅ 청소 완료 시 초기화
          _isRunning = false;
          _elapsedSeconds = 0;
          _totalSeconds = 0;
        }
      });
    });

    // ✅ 시작 / 재개 시 BLE 전송
    if (bleController.isConnected) {
      try {
        String command = (_elapsedSeconds == 0) ? 'start\r\n' : 'restart\r\n';
        await bleController.sendString(command);
      } catch (e) {
        ;
      }
    }
  }

  // 상태 반전은 마지막에
  setState(() {
    _isRunning = !_isRunning;
  });
}


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double barWidth = 392;
    const double imageSize = 30;
    final String estimatedTime = _calculateEstimatedTime(widget.map);

    return SizedBox(
      width: barWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 모드 선택
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: modeIcons.keys.map(_buildModeButton).toList(),
            ),
          ),
          const SizedBox(height: 12),

          // 설명 카드
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(modeIcons[_selectedMode], size: 24, color: const Color(0xFF6ECFF3)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedMode,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.44,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(
                        width: 241,
                        child: Text(
                          '영역에 맞춰 맞춤 청소를 할게요.',
                          style: TextStyle(
                            color: Color(0xFF575A9F),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -1.28,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 예상 시간 및 진행 바
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.98,
                  child: Text(
                    estimatedTime,
                    style: const TextStyle(
                      color: Color(0xFF606A76),
                      fontSize: 16,
                      letterSpacing: -1.44,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 청소기 아이콘
                SizedBox(
                  width: barWidth,
                  height: imageSize,
                  child: Stack(
                    children: [
                      Positioned(
                        left: ((_progress - 0.05) * barWidth) - (imageSize / 2),
                        child: Image.asset(
                          'assets/cleaner.png',
                          width: imageSize,
                          height: imageSize,
                        ),
                      ),
                    ],
                  ),
                ),

                // 진행 바
                Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF6ECFF3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${(_progress * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 버튼 영역
          // 버튼 영역
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 21),
  child: Row(
    children: [
      GestureDetector(
        onTap: _startOrPauseProgress,
        child: Container(
          width: 296,
          height: 40,
          decoration: BoxDecoration(
            color: (!_isRunning && _elapsedSeconds > 0)
    ? const Color(0xFF495F7D) // 일시정지 상태
    : const Color(0xFF14325B), // 시작 또는 진행 중

            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            _isRunning
                ? '일시정지'
                : (_elapsedSeconds > 0 ? '청소 이어하기' : '청소 시작'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              letterSpacing: -1.0,
            ),
          ),
        ),
      ),
      const SizedBox(width: 14),

      // 홈 버튼
      Material(
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () async {
            if (bleController.isConnected) {
              try {
                await bleController.sendString('home\r\n');
              } catch (_) {}
            }

            // 홈 눌러도 일시정지 처리
            if (_isRunning) {
              _timer?.cancel();
              setState(() {
                _isRunning = false;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/home.png',
                width: 32,
                height: 32,
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
    );
  }


  Widget _buildModeButton(String label) {
    final isSelected = _selectedMode == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6ECFF3) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF646B7B),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: -0.96,
          ),
        ),
      ),
    );
  }
}






class SmartCare extends StatelessWidget {
  SmartCare({super.key});

  final BleController bleController = BleController();

  Future<void> sendBleMessage(String message) async {
    if (bleController.isConnected) {
      try {
        await bleController.sendString('$message\r\n');
      } catch (e) {
        print("BLE 전송 중 오류: $e");
      }
    } else {
      print("BLE 연결 안됨. 연결 후 다시 시도하세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD8EBF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartCareItem(
              icon: Icons.oil_barrel,
              text: '기름때 집중 케어',
              onToggle: (isOn) {
                if (isOn) sendBleMessage('oil');
              },
            ),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.water,
              text: '물때 집중 케어',
              onToggle: (isOn) {
                if (isOn) sendBleMessage('water');
              },
            ),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.no_meals,
              text: '부스러기 집중 케어',
              onToggle: (isOn) {
                if (isOn) sendBleMessage('food');
              },
            ),
          ],
        ),
      ),
    );
  }
}



class SmartCareItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final ValueChanged<bool> onToggle;

  const SmartCareItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onToggle,
  });

  @override
  State<SmartCareItem> createState() => _SmartCareItemState();
}

class _SmartCareItemState extends State<SmartCareItem> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          Icon(widget.icon, color: const Color(0xFF495F7D)),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'One UI Sans APP VF',
                fontWeight: FontWeight.w500,
                letterSpacing: -1.44,
              ),
            ),
          ),
          //스위치
          GestureDetector(
            onTap: () {
              setState(() {
                isOn = !isOn;
                widget.onToggle(isOn);
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
          )
        ],
      ),
    );
  }
}


class AftercleanCare extends StatelessWidget {
  AftercleanCare({super.key});

  final BleController bleController = BleController();

  Future<void> sendBleMessage(String message) async {
    if (bleController.isConnected) {
      try {
        await bleController.sendString('$message\r\n');
      } catch (e) {
        print("BLE 전송 중 오류: $e");
      }
    } else {
      print("BLE 연결 안됨. 연결 후 다시 시도하세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD8EBF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmartCareItem(
              icon: Icons.bubble_chart,
              text: '잔수 제거',
              onToggle: (isOn) {
                if (isOn) sendBleMessage('drain');
              },
            ),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.grain,
              text: '먼지통 비우기',
              onToggle: (isOn) {
                if (isOn) sendBleMessage('dust');
              },
            ),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),
            SmartCareItem(
              icon: Icons.soap,
              text: '물걸레 세척',
              onToggle: (isOn) {
                if (isOn) sendBleMessage('mop');
              },
            ),
          ],
        ),
      ),
    );
  }
}



class AddService extends StatelessWidget {
  const AddService({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddServiceItem(
              icon: Icons.settings,
              title: '세부 기능 설정',
              subtitle: '청소의 세부 기능을 설정합니다.',
              onTap: () {
                // 탭 시, DetailFuncPage로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailFuncPage()),
                );
              },
            ),
            const Divider(height: 1, color: Color(0xFFD9D9D9)),
            AddServiceItem(
              icon: Icons.schedule,
              title: '청소 예약',
              subtitle: '청소 시간을 예약해요.',
              onTap: () {
                // 탭 시, CleanReservationPage로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CleanReservation()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class AddServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  

  const AddServiceItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // onTap을 InkWell로 감싸서 클릭 시 동작하도록
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF495F7D), size: 24),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.44,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF575A9F),
                      fontSize: 16,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.28,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFFB0B0B0)),
          ],
        ),
      ),
    );
  }
}