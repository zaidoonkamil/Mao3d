import 'package:flutter/material.dart';

import '../constants.dart';

class FildTimer extends StatelessWidget {
  const FildTimer({
    Key? key,
    this.title,
    this.daysTime,
    this.icons,
    this.ontap,
    required this.widthSize,
  }) : super(key: key);

  final String? title;
  final String? daysTime;
  final IconData? icons;
  final GestureTapCallback? ontap;
  final double widthSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title!,
              style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: textColorAddMeet)),
          GestureDetector(
            onTap: ontap,
            child: Container(
              padding: const EdgeInsets.only(left: 14,right: 14),
              margin: const EdgeInsets.only(top: 8),
              width: widthSize,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  Text(daysTime!,
                      style: TextStyle(
                          fontSize: 16,color: IconColorAddMeet)),
                  const Spacer(),
                  Icon(icons,color: IconColorAddMeet),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
