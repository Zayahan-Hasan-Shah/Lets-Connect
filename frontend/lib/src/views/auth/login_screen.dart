import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/controllers/auth_controller/login_controller/login_api_controller.dart';
import 'package:frontend/src/controllers/auth_controller/login_controller/ui_login_controller.dart';
import 'package:frontend/src/core/app_assets.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/services/common_services/api_service.dart';
import 'package:frontend/src/widgets/common_widgets/custom_button.dart';
import 'package:frontend/src/widgets/common_widgets/custom_snackbar.dart';
import 'package:frontend/src/widgets/common_widgets/custom_text_field.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleText(
                  title: 'Let\'s Connect',
                  fontSize: 22.sp,
                  color: ColorAssets.whiteColor,
                  weight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  AppAssets.logoImage,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width * 0.8,
                ),
                TitleText(
                  title: 'Login',
                  textAlign: TextAlign.left,
                  fontSize: 24.sp,
                  color: ColorAssets.whiteColor,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 1.h),
                _emailBuid(),
                SizedBox(height: 1.h),
                _passwordBuid(),
                SizedBox(height: 1.h),
                _forgotPasswordBuild(),
                SizedBox(height: 2.h),
                _loginButton(),
                _signupRouteBuild(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailBuid() {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: 'joe@email.com',
          hintColor: ColorAssets.hintTextColor,
          fontSize: 16.sp,
        )
      ],
    );
  }

  Widget _passwordBuid() {
    return Column(
      children: [
        CustomTextField(
          controller: passwordController,
          hintText: '******',
          obsText: true,
          hintColor: ColorAssets.hintTextColor,
          fontSize: 16.sp,
        )
      ],
    );
  }

  Widget _loginButton() {
    return Container(
      height: 6.h,
      child: CustomButton(
        buttonBackgroundColor: ColorAssets.buttonColor,
        heightFactor: 1.02,
        widthFactor: 0.6,
        borderRadiusButton: 20,
        alignmentButton: Alignment.center,
        showLoader: true,
        onTap: () async {
          if (formkey.currentState!.validate()) {
            ref.read(customButtonController.notifier).state = true;
            try {
              await onInit(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
            } finally {
              ref.read(customButtonController.notifier).state = false;
            }
          } else {
            log("Form is invalid. Show errors.");
          }
        },
        child: TitleText(
          title: 'Login',
          fontSize: 22.sp,
          textAlign: TextAlign.center,
          color: ColorAssets.whiteColor,
        ),
      ),
    );
  }

  Widget _forgotPasswordBuild() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.push('/forgetpassword');
        },
        child: TitleText(
          title: 'Forgot password?',
          color: ColorAssets.whiteColor,
        ),
      ),
    );
  }

  Widget _signupRouteBuild() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          context.push('/signup');
        },
        child: TitleText(
          title: 'Register your account',
          color: ColorAssets.whiteColor,
        ),
      ),
    );
  }

  Future<void> onInit(String email, String password) async {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    try {
      loginNotifier.setLoginButtonLoaderState(true);

      final response =
          await ref.read(loginAuthProvider.notifier).loginAuth(email, password);

      if (response != null) {
        tokenKey = response.accessToken;

        CustomSnackbar.show(
          context: context,
          message: 'Successfully Logged In',
          title: 'Welcome',
          backgroundColor: ColorAssets.successColor,
        );

        // ✅ Navigate only on success
        context.go('/bottompage');
      } else {
        CustomSnackbar.show(
          context: context,
          message: 'Invalid Credentials',
          title: 'Please Try Again',
          backgroundColor: ColorAssets.errorColor,
        );
      }
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(
        context: context,
        message: 'An error occurred',
        title: 'Please try again later',
        backgroundColor: ColorAssets.errorColor,
      );
    } finally {
      loginNotifier.setLoginButtonLoaderState(false);
    }
  }
}
