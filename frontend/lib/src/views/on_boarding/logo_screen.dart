import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/routes/route_names.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:go_router/go_router.dart';

class LogoScreen extends ConsumerStatefulWidget {
  const LogoScreen({super.key});

  @override
  ConsumerState<LogoScreen> createState() => LogoScreenState();
}

class LogoScreenState extends ConsumerState<LogoScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  void initialization() async {
    try {} catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    initialization();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeInOut);

    _controller?.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      try {
        context.go(RouteNames.loginScreen);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation!,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation?.value ?? 1,
                  child: Transform.scale(
                    scale: _animation?.value,
                    child: child,
                  ),
                );
              },
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TitleText(
                      title: 'Let\'s Connect',
                      fontSize: 32,
                      color: ColorAssets.whiteColor,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
