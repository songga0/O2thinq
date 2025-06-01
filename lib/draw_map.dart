import 'package:flutter/material.dart';

class DrawMap extends StatelessWidget {
  final List<List<int>> mapData;

  const DrawMap(this.mapData, {super.key});

  @override
  Widget build(BuildContext context) {
    int rowCount = mapData.length;
    int colCount = mapData[0].length;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 화면 내 최대 지도 크기 비율 설정
    final maxWidth = screenWidth * 0.9;
    final maxHeight = screenHeight * 0.6;

    double squareWidth = maxWidth / colCount;
    double squareHeight = maxHeight / rowCount;

    double baseSize = squareWidth < squareHeight ? squareWidth : squareHeight;

  
    double scaleFactor = 0.89;
    double squareSize = baseSize * scaleFactor;

    // BFS로 2인 영역 찾기
    List<List<bool>> visited = List.generate(rowCount, (_) => List.filled(colCount, false));
    List<_Rect> inductionAreas = [];

    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < colCount; col++) {
        if (mapData[row][col] == 2 && !visited[row][col]) {
          var rect = _bfsFindArea(mapData, visited, row, col, rowCount, colCount);
          inductionAreas.add(rect);
        }
      }
    }

    return SizedBox(
      width: colCount * squareSize,
      height: rowCount * squareSize,
      child: Stack(
        children: [
          Table(
            defaultColumnWidth: FixedColumnWidth(squareSize),
            border: TableBorder.all(color: Colors.transparent),
            children: List.generate(rowCount, (row) {
              return TableRow(
                children: List.generate(colCount, (col) {
                  int val = mapData[row][col];
                  return Container(
                    width: squareSize,
                    height: squareSize,
                    color: val == 1
                        ? const Color(0xFFE8E8E8)
                        : val == 2
                            ? Colors.orange.shade100
                            : Colors.white,
                  );
                }),
              );
            }),
          ),
          for (var area in inductionAreas)
            Positioned(
              top: area.minRow * squareSize,
              left: area.minCol * squareSize,
              width: (area.maxCol - area.minCol + 1) * squareSize,
              height: (area.maxRow - area.minRow + 1) * squareSize,
              child: DrawInduction(
                width: (area.maxCol - area.minCol + 1) * squareSize,
                height: (area.maxRow - area.minRow + 1) * squareSize,
              ),
            ),
        ],
      ),
    );
  }

  _Rect _bfsFindArea(List<List<int>> mapData, List<List<bool>> visited, int startRow, int startCol, int rowCount, int colCount) {
    int minRow = startRow, maxRow = startRow;
    int minCol = startCol, maxCol = startCol;

    final queue = <List<int>>[];
    queue.add([startRow, startCol]);
    visited[startRow][startCol] = true;

    final directions = [
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1],
    ];

    while (queue.isNotEmpty) {
      var current = queue.removeAt(0);
      int r = current[0], c = current[1];

      for (var d in directions) {
        int nr = r + d[0], nc = c + d[1];
        if (nr >= 0 && nr < rowCount && nc >= 0 && nc < colCount) {
          if (!visited[nr][nc] && mapData[nr][nc] == 2) {
            visited[nr][nc] = true;
            queue.add([nr, nc]);
            if (nr < minRow) minRow = nr;
            if (nr > maxRow) maxRow = nr;
            if (nc < minCol) minCol = nc;
            if (nc > maxCol) maxCol = nc;
          }
        }
      }
    }
    return _Rect(minRow, maxRow, minCol, maxCol);
  }
}

class DrawMapMin extends StatelessWidget {
  final List<List<int>> mapData;

  const DrawMapMin(this.mapData, {super.key});

  @override
  Widget build(BuildContext context) {
    int rowCount = mapData.length;
    int colCount = mapData[0].length;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 화면 내 최대 지도 크기 비율 설정
    final maxWidth = screenWidth * 0.73;
    final maxHeight = screenHeight * 0.5;

    double squareWidth = maxWidth / colCount;
    double squareHeight = maxHeight / rowCount;

    double baseSize = squareWidth < squareHeight ? squareWidth : squareHeight;

  
    double scaleFactor = 0.89;
    double squareSize = baseSize * scaleFactor;

    // BFS로 2인 영역 찾기
    List<List<bool>> visited = List.generate(rowCount, (_) => List.filled(colCount, false));
    List<_Rect> inductionAreas = [];

    for (int row = 0; row < rowCount; row++) {
      for (int col = 0; col < colCount; col++) {
        if (mapData[row][col] == 2 && !visited[row][col]) {
          var rect = _bfsFindArea(mapData, visited, row, col, rowCount, colCount);
          inductionAreas.add(rect);
        }
      }
    }

    return SizedBox(
      width: colCount * squareSize,
      height: rowCount * squareSize,
      child: Stack(
        children: [
          Table(
            defaultColumnWidth: FixedColumnWidth(squareSize),
            border: TableBorder.all(color: Colors.transparent),
            children: List.generate(rowCount, (row) {
              return TableRow(
                children: List.generate(colCount, (col) {
                  int val = mapData[row][col];
                  return Container(
                    width: squareSize,
                    height: squareSize,
                    color: val == 1
                        ? const Color(0xFFE8E8E8)
                        : val == 2
                            ? Colors.orange.shade100
                            : Colors.white,
                  );
                }),
              );
            }),
          ),
          for (var area in inductionAreas)
            Positioned(
              top: area.minRow * squareSize,
              left: area.minCol * squareSize,
              width: (area.maxCol - area.minCol + 1) * squareSize,
              height: (area.maxRow - area.minRow + 1) * squareSize,
              child: DrawInduction(
                width: (area.maxCol - area.minCol + 1) * squareSize,
                height: (area.maxRow - area.minRow + 1) * squareSize,
              ),
            ),
        ],
      ),
    );
  }

  _Rect _bfsFindArea(List<List<int>> mapData, List<List<bool>> visited, int startRow, int startCol, int rowCount, int colCount) {
    int minRow = startRow, maxRow = startRow;
    int minCol = startCol, maxCol = startCol;

    final queue = <List<int>>[];
    queue.add([startRow, startCol]);
    visited[startRow][startCol] = true;

    final directions = [
      [1, 0],
      [-1, 0],
      [0, 1],
      [0, -1],
    ];

    while (queue.isNotEmpty) {
      var current = queue.removeAt(0);
      int r = current[0], c = current[1];

      for (var d in directions) {
        int nr = r + d[0], nc = c + d[1];
        if (nr >= 0 && nr < rowCount && nc >= 0 && nc < colCount) {
          if (!visited[nr][nc] && mapData[nr][nc] == 2) {
            visited[nr][nc] = true;
            queue.add([nr, nc]);
            if (nr < minRow) minRow = nr;
            if (nr > maxRow) maxRow = nr;
            if (nc < minCol) minCol = nc;
            if (nc > maxCol) maxCol = nc;
          }
        }
      }
    }
    return _Rect(minRow, maxRow, minCol, maxCol);
  }
}

class _Rect {
  final int minRow, maxRow, minCol, maxCol;
  _Rect(this.minRow, this.maxRow, this.minCol, this.maxCol);
}

class DrawInduction extends StatelessWidget {
  final double width;
  final double height;

  const DrawInduction({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F3F3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circle(size: width * 0.6),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _circle(size: width * 0.3),
                const SizedBox(width: 10),
                _circle(size: width * 0.3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle({required double size}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const ShapeDecoration(
            color: Color(0xFFCACACA),
            shape: OvalBorder(),
          ),
        ),
        Container(
          width: size - 2,
          height: size - 2,
          decoration: const ShapeDecoration(
            color: Color(0xFFF3F3F3),
            shape: OvalBorder(),
          ),
        ),
      ],
    );
  }
}
