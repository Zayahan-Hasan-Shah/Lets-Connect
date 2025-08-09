import 'package:flutter/material.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;

  TitleText({
    Key? key,
    required this.title,
    this.style,
    this.fontSize,
    this.weight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.softWrap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines ?? null,
      softWrap: softWrap ?? true,
      style: style ??
          GoogleFonts.spaceGrotesk(
            fontSize: fontSize ?? 14,
            fontWeight: weight ?? FontWeight.normal,
            color: color ?? ColorAssets.whiteColor,
          ),
    );
  }
}