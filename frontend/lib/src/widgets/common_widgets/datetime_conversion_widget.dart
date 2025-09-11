import 'package:flutter/material.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DatetimeConversionWidget extends StatelessWidget {
  final String isoDateTime; // e.g. "2025-09-10T09:37:44.000Z"
  final TextStyle? style;
  const DatetimeConversionWidget({
    super.key,
    required this.isoDateTime,
    this.style,
  });

  String _formatDateTime(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate).toLocal();
      final formatter = DateFormat('HH:mm:ss - dd, MMM, yyyy');
      return formatter.format(dateTime);
    } catch (_) {
      return isoDate; // fallback in case parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return TitleText(
      title: _formatDateTime(isoDateTime),
      fontSize: 12.sp,
      color: ColorAssets.postCardColor,
    );
  }
}
