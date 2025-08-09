import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';

final customButtonController = StateProvider<bool>((ref) {
  return false;
});

class CustomButton extends StatelessWidget {
  final String? title;
  final double? widthFactor;
  final VoidCallback onTap;
  final bool? hasPadding;
  final double? heightFactor;
  final Widget? child;
  final bool showLoader; // 👈 Not nullable now
  final FontWeight? titleWeight;
  final double? titleSize;
  final Color? titleColor;
  final Alignment? alignmentButton;
  final double? borderRadiusButton;
  final Color? buttonBackgroundColor;
  final MaterialStateProperty<Color?>? color;

  const CustomButton({
    Key? key,
    this.title,
    this.titleColor,
    required this.onTap,
    this.child,
    this.color,
    this.widthFactor,
    this.hasPadding,
    this.showLoader = false,
    this.titleSize,
    this.titleWeight,
    this.heightFactor,
    this.alignmentButton,
    this.borderRadiusButton,
    this.buttonBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, widget) {
        final isLoading = ref.watch(customButtonController);

        return FractionallySizedBox(
          heightFactor: heightFactor,
          widthFactor: widthFactor ?? 0.8,
          child: ElevatedButton(
            onPressed: isLoading ? null : onTap, 
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusButton ?? 16),
              ),
            ),
            child: isLoading && showLoader
                ? Center(
                    child: Transform.scale(
                      scale: 0.7,
                      child: const CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorAssets.whiteColor),
                      ),
                    ),
                  )
                : child ??
                    TitleText(
                      title: title ?? '',
                      weight: titleWeight,
                      fontSize: titleSize,
                      color: titleColor ?? ColorAssets.whiteColor,
                    ),
          ),
        );
      },
    );
  }
}
