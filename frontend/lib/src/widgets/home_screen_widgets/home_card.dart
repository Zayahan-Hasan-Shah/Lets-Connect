import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/widgets/common_widgets/datetime_conversion_widget.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:sizer/sizer.dart';

class HomeCard extends StatelessWidget {
  final String desc;
  final File? asset;
  final String time;
  final String userName;
  final int? likes;
  final VoidCallback onTap;
  final VoidCallback likeTap;

  const HomeCard({
    super.key,
    required this.desc,
    this.asset,
    required this.time,
    required this.userName,
    required this.likes,
    required this.onTap,
    required this.likeTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
          color: ColorAssets.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(6, 6),
              blurRadius: 12,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              offset: const Offset(1, -2),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: user + time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  title: userName,
                  fontSize: 20.sp,
                  color: ColorAssets.whiteColor,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorAssets.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        offset: const Offset(-2, -2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: DatetimeConversionWidget(isoDateTime: time),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Description
            TitleText(
              title: desc,
              fontSize: 14.sp,
              color: ColorAssets.postCardColor,
              height: 1.4,
            ),
            SizedBox(height: 2.h),

            // Asset (optional image)
            if (asset != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  asset!,
                  height: 20.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            SizedBox(height: 2.h),

            // Likes + action row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: likeTap,
                  child: TitleText(
                    title: "❤️ ${likes ?? 0} Likes",
                    fontSize: 14.sp,
                    color: ColorAssets.whiteColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ColorAssets.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        offset: const Offset(-2, -2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Text(
                    "💬 Comment",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
