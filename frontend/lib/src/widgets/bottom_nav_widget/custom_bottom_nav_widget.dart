import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/models/bottom_nav_model.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavWidget extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;
  const CustomBottomNavWidget(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 10.h,
      // padding: EdgeInsets.all(0.1.h),
      decoration: const BoxDecoration(
        color: ColorAssets.buttonColor,
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        border: Border(
          top: BorderSide(
            color: ColorAssets.whiteColor, 
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorAssets.whiteColor,
            blurRadius: 14,
            offset: Offset(0, -0.5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        unselectedItemColor: ColorAssets.hintTextColor,
        showUnselectedLabels: true,
        selectedItemColor: ColorAssets.whiteColor,
        currentIndex: currentIndex,
        elevation: 0,
        
        backgroundColor: Colors.transparent,
        onTap: onTap,
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(
                  item.icon,
                  size: 3.h,
                ),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
