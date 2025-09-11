import 'package:flutter/material.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isback;

  const CustomAppbar({
    super.key,
    required this.title,
    this.isback = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: ColorAssets.whiteColor),
      backgroundColor: ColorAssets.buttonColor,
      elevation: 1,
      title: TitleText(
          title: title, fontSize: 18.sp, color: ColorAssets.whiteColor,),
      leading: isback
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                color: ColorAssets.whiteColor,
              ))
          : null,
    );
  }
}
