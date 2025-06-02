import 'package:flutter/material.dart';

class StationGoodsCarePage extends StatelessWidget {
  final int liquidUsageCount;
  final int stfilterUsageCount;
  final int dustbagUsageCount;

  const StationGoodsCarePage({
    super.key,
    required this.liquidUsageCount,
    required this.stfilterUsageCount,
    required this.dustbagUsageCount,
    

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F4),
      appBar: AppBar(
        title: const Text('스테이션 소모품 관리'),
        backgroundColor: const Color(0xFFEFF1F4),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 21, right: 21),
        child: Column(
          children: [
            Liquid(usageCount: liquidUsageCount),
            const SizedBox(height: 20),
            StFilter(usageCount: stfilterUsageCount),
            const SizedBox(height: 20),
            DustBag(usageCount: dustbagUsageCount),
            
          ],
        ),
      ),
    );
  }
}


class DustBag extends StatelessWidget {
  final int usageCount;

  const DustBag({super.key, required this.usageCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '먼지봉투',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w500,
              letterSpacing: -1.44,
            ),
          ),
          const SizedBox(height: 16),
          ClothStatusBar(
            usageCount: usageCount,
            replacementDate: '2025.05.07',
            maxUsageCount: 100, 
          ),
        ],
      ),
    );
  }
}

class Liquid extends StatelessWidget {
  final int usageCount;

  const Liquid({super.key, required this.usageCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '청소액',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w500,
              letterSpacing: -1.44,
            ),
          ),
          const SizedBox(height: 16),
          ClothStatusBar(
            usageCount: usageCount,
            replacementDate: '2025.05.07',
            maxUsageCount: 90, // 걸레 최대 사용 횟수
          ),
        ],
      ),
    );
  }
}

class StFilter extends StatelessWidget {
  final int usageCount;

  const StFilter({super.key, required this.usageCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '필터',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'One UI Sans APP VF',
              fontWeight: FontWeight.w500,
              letterSpacing: -1.44,
            ),
          ),
          const SizedBox(height: 16),
          ClothStatusBar(
            usageCount: usageCount,
            replacementDate: '2025.05.22',
            maxUsageCount: 150, // 필터 최대 사용 횟수
          ),
        ],
      ),
    );
  }
}

class ClothStatusBar extends StatelessWidget {
  final int usageCount; // 현재 사용 횟수
  final int maxUsageCount; // 최대 사용 횟수 (필터 150, 걸레 300)
  final String replacementDate;

  const ClothStatusBar({
    super.key,
    required this.usageCount,
    required this.replacementDate,
    this.maxUsageCount = 300,
  });

  @override
  Widget build(BuildContext context) {
    final usagePercentage = (usageCount.clamp(0, maxUsageCount)) / maxUsageCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            double arrowPosition = usagePercentage * barWidth;
            arrowPosition = arrowPosition.clamp(15, barWidth - 15);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: const [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0XFFB6E2A1)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0XFFFFFBC1)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0XFFFF8080)),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: arrowPosition - 15,
                  top: -24,
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Colors.black87,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            '교체일: $replacementDate',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, top: 2),
          child: Text(
            '사용 횟수: $usageCount / $maxUsageCount',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
