import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/routes/route_names.dart';
import 'package:frontend/src/views/auth/forget_password.dart';
import 'package:frontend/src/views/auth/login_screen.dart';
import 'package:frontend/src/views/auth/signup_screen.dart';
import 'package:frontend/src/views/auth/verification_number.dart';
import 'package:frontend/src/views/bottom_navigation_screens/bottom_navigation_screen.dart';
import 'package:frontend/src/views/bottom_navigation_screens/screens/chat/chat_list_user_screen.dart';
import 'package:frontend/src/views/bottom_navigation_screens/screens/home/home_screen.dart';
import 'package:frontend/src/views/bottom_navigation_screens/screens/profile/profile_screen.dart';
import 'package:frontend/src/views/on_boarding/logo_screen.dart';
import 'package:frontend/src/views/on_boarding/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splashScreen,
    routes: [
      GoRoute(path: RouteNames.splashScreen, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RouteNames.logoScreen, builder: (context, state) => const LogoScreen()),
      GoRoute(path: RouteNames.loginScreen, builder: (context, state) => const LoginScreen()),
      GoRoute(path: RouteNames.signupScreen, builder: (context, state) => const SignupScreen()),
      GoRoute(path: RouteNames.forgetPassword, builder: (context, state) => const  ForgetPassword()),
      GoRoute(path: RouteNames.verficationNumber, builder: (context, state) => const  VerificationNumber()),
      GoRoute(path: RouteNames.homeScreen, name: RouteNames.homeScreen, builder: (context, state) => const HomeScreen()),
      GoRoute(path: RouteNames.chatListScreen, name: RouteNames.chatListScreen, builder: (context, state) => const ChatListUserScreen()),
      GoRoute(path: RouteNames.profileScreen, name: RouteNames.profileScreen, builder: (context, state) => const ProfileScreen()),
      GoRoute(path: RouteNames.bottomNavPage, name: RouteNames.bottomNavPage, builder: (context, state) => const BottomNavigationScreen()),
    ],
  );
});