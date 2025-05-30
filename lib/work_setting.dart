import 'package:flutter/material.dart';

class CleanSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 392,
          height: 658,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Container(
                width: 392,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 9,
                  children: [
                    Container(
                      width: 392,
                      height: 23,
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '청소 영역',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.45,
                              fontFamily: 'One UI Sans APP VF',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.35,
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            ]
          )
        )
      ]
    );
  }

}