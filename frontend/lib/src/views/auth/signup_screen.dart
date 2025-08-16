import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/src/controllers/auth_controller/signup_controller/signup_api_controller.dart';
import 'package:frontend/src/controllers/auth_controller/signup_controller/ui_signup_controller.dart';
import 'package:frontend/src/core/app_assets.dart';
import 'package:frontend/src/core/color_assets.dart';
import 'package:frontend/src/utils/app_validation.dart';
import 'package:frontend/src/widgets/common_widgets/custom_button.dart';
import 'package:frontend/src/widgets/common_widgets/custom_snackbar.dart';
import 'package:frontend/src/widgets/common_widgets/custom_text_field.dart';
import 'package:frontend/src/widgets/common_widgets/title_text.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TitleText(
                  title: 'Let\'s Connect',
                  fontSize: 20.sp,
                  color: ColorAssets.whiteColor,
                  weight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  AppAssets.logoImage,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width  * 0.8,
                  fit: BoxFit.cover,
                ),
                TitleText(
                  title: 'Register',
                  fontSize: 20.sp,
                  color: ColorAssets.whiteColor,
                  weight: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 1.h),
                _userNameBuid(),
                SizedBox(height: 1.h),
                _phoneNumberBuid(),
                SizedBox(height: 1.h),
                _emailBuid(),
                SizedBox(height: 1.h),
                _passwordBuid(),
                SizedBox(height: 2.h),
                _signupButton(),
                _loginRouteBuild(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userNameBuid() {
    return Column(
      children: [
        CustomTextField(
          controller: userNameController,
          hintText: 'Hitmam_12',
          hintColor: ColorAssets.hintTextColor,
          fontSize: 16.sp,
          validator: AppValidation.userNameVaildation,
        )
      ],
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
          validator: AppValidation.emailValidation,
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
          validator: AppValidation.passwordValidation,
        )
      ],
    );
  }

  Widget _phoneNumberBuid() {
    return Column(
      children: [
        CustomTextField(
          controller: phoneNumberController,
          hintText: '9231XXXXXXX',
          hintColor: ColorAssets.hintTextColor,
          fontSize: 16.sp,
          validator: AppValidation.phoneNumberValidation,
        )
      ],
    );
  }

  Widget _signupButton() {
    final signupState = ref.watch(signupNotifierProvider);
    final signupNotifier = ref.read(signupNotifierProvider.notifier);
    return SizedBox(
      height: 6.h,
      child: Center(
        child: CustomButton(
          buttonBackgroundColor: ColorAssets.buttonColor,
          heightFactor: 1.02,
          widthFactor: 0.6,
          borderRadiusButton: 20,
          alignmentButton: Alignment.center,
          showLoader: signupState.buttonLoader,
          onTap: () async {
            if (formkey.currentState!.validate()) {
              log("Form is valid. Proceed with signup.");
              try {
                await onInit(
                    userNameController.text.trim(),
                    emailController.text.trim(),
                    passwordController.text.trim(),
                    phoneNumberController.text.trim());
              } finally {
                ref.read(customButtonController.notifier).state = false;
              }
              // pushNamed(AppRoutes.profileUpdateScreen);
            } else {
              log("Form is invalid. Show errors.");
            }
          },
          child: TitleText(
            title: 'Register',
            fontSize: 22.sp,
            textAlign: TextAlign.center,
            color: ColorAssets.whiteColor,
          ),
        ),
      ),
    );
  }

Widget _loginRouteBuild() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () { context.push('/login');},
        child: TitleText(
          title: 'Already have an account? Login',
          color: ColorAssets.whiteColor,
        ),
      ),
    );
  }

  Future<void> onInit(String userName, String email, String password,
      String phoneNumber) async {
    final signupNotifier = ref.read(signupNotifierProvider.notifier);
    try {
      final response = await ref
          .read(signupAuthProvider.notifier)
          .signupAuth(userName, email, password, phoneNumber);
      if (response != null) {
        String userName = response.userName;
        String email = response.email;
        String password = response.password;
        String phoenNumber = response.phoneNumber;
      }
    } catch (e) {
      log(e.toString());
      CustomSnackbar.show(
        context: context,
        message: "An error occured",
        title: "Signup failed",
        backgroundColor: ColorAssets.errorColor,
      );
    } finally {
      signupNotifier.setSignupButtonLoaderState(false);
    }
  }
}
