import 'dart:math';

import 'package:flutter/material.dart';

class DeviceSetting extends StatelessWidget {
  const DeviceSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:GestureDetector(
      child: Column(
        children: [SizedBox(
                    width: 352,
                    child: Text(
                      '히스토리',
                      style: TextStyle(
                        color: const Color(0xFF606A76),
                        fontSize: 17.45,
                        fontFamily: 'One UI Sans APP VF',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.35,
                      )
                    )
                  ),SizedBox(height: 8,),
                  CleanHistory(),
                  SizedBox(height: 12,) ,
                  SizedBox(
                    width: 352,
                    child: Text(
                      '소모품 관리',
                      style: TextStyle(
                        color: const Color(0xFF606A76),
                        fontSize: 17.45,
                        fontFamily: 'One UI Sans APP VF',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.35,
                      )
                    )
                  ),SizedBox(height: 8,),
                  GoodsInfo(),
                  SizedBox(height: 12,),
                  GoodsCare(),
                  SizedBox(height: 12,),
                  StationGoodsCare(),
                  SizedBox(height: 12,),
                  SizedBox(
                    width: 352,
                    child: Text(
                      '유용한 기능',
                      style: TextStyle(
                        color: const Color(0xFF606A76),
                        fontSize: 17.45,
                        fontFamily: 'One UI Sans APP VF',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.35,
                      )
                    )
                  ),SizedBox(height: 12,),
                   Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Property1Variant6(
                            title: '스마트 진단',
                            subtitle: '최근 진단 결과 없음',
                          ),
                          const SizedBox(width: 12),
                          Property1Variant6(
                            title: '사용 설명서',
                            subtitle: '사용법이 궁금하신가요?',
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 23,)
        ],
      ),
    )
          )
        ]
      )
    );
  } 
}

class Property1Variant6 extends StatelessWidget {
  final String title;
  final String subtitle;

  const Property1Variant6({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 179,
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ⬇️ 아이콘 조건 처리
          title == '스마트 진단'
              ? Icon(
                  Icons.auto_fix_normal,
                  color: const Color(0xFF4A58BB),
                  size: 24,
                )
              : Icon(
                  Icons.menu_book,
                  color: const Color(0xFF4A58BB),
                  size: 24,
                ),
          const SizedBox(height: 16),
          // 제목 텍스트
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
          const SizedBox(height: 7),
          // 설명 텍스트
          SizedBox(
            width: 125,
            child: Opacity(
              opacity: 0.98,
              child: Text(
                subtitle,
                style: const TextStyle(
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
    );
  }
}
class GoodsCare extends StatefulWidget {
  const GoodsCare({super.key});

  @override
  State<GoodsCare> createState() => _GoodsCareState();
}

class _GoodsCareState extends State<GoodsCare> {
  final int mopUsageCount = 113; // 예시 값
  final int filterUsageCount = 88;
  final int rollerUsageCount=40;
  final int sideUsageCount=16;

  String getMopStatusText() {
    return mopUsageCount <= 90 ? '양호' : '교체필요';
  }

  Color getMopStatusColor() {
    return mopUsageCount <= 90 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  String getFilterStatusText() {
    return filterUsageCount <= 50 ? '양호' : '교체필요';
  }

  Color getFilterStatusColor() {
    return filterUsageCount <= 50 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  String getRollerStatusText() {
    return mopUsageCount <= 90 ? '양호' : '교체필요';
  }

  Color getRollerStatusColor() {
    return mopUsageCount <= 90 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  String getSideStatusText() {
    return sideUsageCount <= 90 ? '양호' : '교체필요';
  }

  Color getSideStatusColor() {
    return sideUsageCount <= 90 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목 및 아이콘
          Row(
            children: [
              const Icon(
                Icons.cleaning_services,
                color: Color(0xFF4A58BB),
                size: 28,
              ),
              const SizedBox(width: 22),
              const Text(
                '브릭봇 소모품관리',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.44,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/Right.png'),
              ),
            ],
          ),

          const SizedBox(height: 23),

          // 필터 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '걸레',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.44,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getMopStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getMopStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 걸레 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getFilterStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getFilterStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),const SizedBox(height: 20),

          // 걸레 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '롤러 브러쉬',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.44,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getRollerStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getRollerStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '사이드 브러쉬',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.44,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getSideStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getSideStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StationGoodsCare extends StatefulWidget {
  const StationGoodsCare({super.key});

  @override
  State<StationGoodsCare> createState() => _StationGoodsCareState();
}

class _StationGoodsCareState extends State<StationGoodsCare> {
  final int liquidUsageCount = 120; 
  final int stfilterUsageCount = 37;
  final int dustUsageCount=88;

  String getLiquidStatusText() {
    return liquidUsageCount <= 90 ? '양호' : '교체필요';
  }

  Color getLiquidStatusColor() {
    return liquidUsageCount <= 90 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  String getStFilterStatusText() {
    return stfilterUsageCount <= 50 ? '양호' : '교체필요';
  }

  Color getStFilterStatusColor() {
    return stfilterUsageCount <= 50 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  String getDustStatusText() {
    return dustUsageCount <= 90 ? '양호' : '교체필요';
  }

  Color getDustStatusColor() {
    return dustUsageCount <= 90 ? const Color(0xFF4CAF50) : const Color(0xFFFF8080);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목 및 아이콘
          Row(
            children: [
              const Icon(
                Icons.other_houses,
                color: Color(0xFF4A58BB),
                size: 28,
              ),
              const SizedBox(width: 22),
              const Text(
                '스테이션 소모품관리',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.44,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/Right.png'),
              ),
            ],
          ),

          const SizedBox(height: 23),

          // 필터 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getLiquidStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getLiquidStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 걸레 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getStFilterStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getStFilterStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),const SizedBox(height: 20),

          // 걸레 상태
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                children: [
                  Icon(Icons.lightbulb, color: getDustStatusColor(), size: 24),
                  const SizedBox(width: 4),
                  Text(
                    getDustStatusText(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Consumable {
  final String name;
  final String code;
  final String discountRate;
  final String discountedPrice;
  final String originalPrice;

  Consumable({
    required this.name,
    required this.code,
    required this.discountRate,
    required this.discountedPrice,
    required this.originalPrice,
  });
}


class GoodsInfo extends StatelessWidget {
  const GoodsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Consumable> consumables = [
      Consumable(
        name: '주방용 세정액',
        code: 'SGY20010307',
        discountRate: '10%',
        discountedPrice: '9,540',
        originalPrice: '10,600원',
      ),
      Consumable(
        name: '주방 세제',
        code: 'SYG19960726',
        discountRate: '10%',
        discountedPrice: '6,363',
        originalPrice: '7,070원',
      ),
      Consumable(
        name: '부착용 브러쉬',
        code: 'JJW880113',
        discountRate: '5%',
        discountedPrice: '4,940',
        originalPrice: '5,200원',
      ),
      Consumable(
        name: '부착용 걸레',
        code: 'KSS19950416',
        discountRate: '10%',
        discountedPrice: '8,325',
        originalPrice: '9,250원',
      ),
    ];

    final random = Random();
    final picked = <Consumable>[];
    while (picked.length < 2) {
      final c = consumables[random.nextInt(consumables.length)];
      if (!picked.contains(c)) picked.add(c);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.card_giftcard, color: Color(0xFF4A58BB), size: 28),
              const SizedBox(width: 22),
              const Text(
                '소모품 추천',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.44,
                  fontFamily: 'One UI Sans APP VF',
                ),
              ),
            ],
          ),
          const SizedBox(height: 23),
          const Text(
            '내 제품에 필요한 소모품을 확인해보세요.',
            style: TextStyle(
              color: Color(0xFF606A76),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: -1.44,
              fontFamily: 'One UI Sans APP VF',
            ),
          ),
          const SizedBox(height: 23),
          SizedBox(
            height: 134,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: picked.length,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (_, index) {
                return _buildCard(picked[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Consumable item) {
  return Container(
    width: 268, // 90 + 141 + padding 고려
    height: 134,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color(0xFFF5F5F5),
    ),
    child: Row(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 141,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.44,
                ),
              ),
              Text(
                '(${item.code})',
                style: const TextStyle(
                  color: Color(0xFF696D77),
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1.26,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    item.discountRate,
                    style: const TextStyle(
                      color: Color(0xFFA00D2C),
                      fontSize: 18,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1.62,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${item.discountedPrice}원',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'One UI Sans APP VF',
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.36,
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
              Opacity(
                opacity: 0.20,
                child: Text(
                  item.originalPrice,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'One UI Sans APP VF',
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                    letterSpacing: -0.8,
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
}


class CleanHistory extends StatelessWidget {
 

  const CleanHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SizedBox(height: 12,),
          // 상단 타이틀 및 아이콘 Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,  // 전달된 아이콘 사용
                    color: Color(0xFF4A58BB),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "청소 히스토리",  // 전달된 title 텍스트 사용
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/Right.png',
                width: 24,
                height: 24,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: 352,
            height: 1,
            decoration: BoxDecoration(color: const Color(0xFFD9D9D9)),
          ),const SizedBox(height: 23),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.workspace_premium,  // 전달된 아이콘 사용
                    color: Color(0xFF4A58BB),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "이달의 청소모드",  
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'One UI Sans APP VF',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.44,
                    ),
                  ),
                ],
              ),
            ],
          ),const SizedBox(height: 12),
          Padding(
  padding: const EdgeInsets.only(left: 21),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 145,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 145,
              child: Text(
                '청소 모드',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.12,
                ),
              ),
            ),
            SizedBox(
              width: 145,
              child: Text(
                '스마트 케어 모드',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.60,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 20), // spacing 대신 SizedBox로 간격 추가
      Container(
        width: 145,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 145,
              child: Text(
                '횟수',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.12,
                ),
              ),
            ),
            SizedBox(
              width: 145,
              child: Text(
                '22회',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'One UI Sans APP VF',
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.80,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

                          
        ],
      ),
    );
  }
}
