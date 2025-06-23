import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final double iconWidth;
  final double iconHeight;
  final double fontSize;
  final double letterSpacing;
  final EdgeInsets padding;
  final double? width;
  final String icon;

  const ActionButton({
    Key? key,
    required this.text,
    required this.iconWidth,
    required this.iconHeight,
    required this.fontSize,
    required this.letterSpacing,
    required this.padding,
    this.width, 
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 51,
      decoration: BoxDecoration(
        color: const Color(0xFF232323),
        borderRadius: BorderRadius.circular(width != null ? 16 : 14.202),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                letterSpacing: letterSpacing,
                
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: iconWidth,
              height: iconHeight,
              child: Image.asset(icon, color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
