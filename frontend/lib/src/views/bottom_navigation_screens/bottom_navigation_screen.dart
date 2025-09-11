import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/controllers/bottom_navigation_controller/bottom_navigation_controller.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/models/bottom_nav_model/bottom_nav_model.dart';
import 'package:frontend/src/views/bottom_navigation_screens/screens/chat/chat_list_user_screen.dart';
import 'package:frontend/src/views/bottom_navigation_screens/screens/home/home_screen.dart';
import 'package:frontend/src/views/bottom_navigation_screens/screens/profile/profile_screen.dart';
import 'package:frontend/src/widgets/bottom_nav_widget/custom_bottom_nav_widget.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigationScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatListUserScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavigationProvider);
    return Scaffold(
      backgroundColor: ColorAssets.backgroundColor,
      body: _screens[currentIndex],
      bottomNavigationBar: CustomBottomNavWidget(
        currentIndex: currentIndex,
        onTap: (index) =>
            ref.read(bottomNavigationProvider.notifier).setIndex(index),
        items: [
          BottomNavItem(icon: Icons.home, label: 'Home'),
          BottomNavItem(icon: Icons.chat, label: 'Chat'),
          BottomNavItem(icon: Icons.person, label: 'Profile'),
          // BottomNavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
    );
  }
}
